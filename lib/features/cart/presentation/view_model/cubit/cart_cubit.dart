import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/cart/data/models/cart_item_model.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/cart/domain/use_cases/add_to_cart_use_case.dart';
import 'package:stylish_app/features/cart/domain/use_cases/calculate_subtotal_use_case.dart';
import 'package:stylish_app/features/cart/domain/use_cases/clear_local_cart_use_case.dart';
import 'package:stylish_app/features/cart/domain/use_cases/decrement_cart_item_use_case.dart';
import 'package:stylish_app/features/cart/domain/use_cases/get_cart_items_use_case.dart';
import 'package:stylish_app/features/cart/domain/use_cases/increment_cart_item_use_case.dart';
import 'package:stylish_app/features/cart/domain/use_cases/remove_from_cart_use_case.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  StreamSubscription<User?>? _authSubscription;

  CartCubit({
    required this.auth,
    required this.getCartItemsUseCase,
    required this.addToCartUseCase,
    required this.calculateSubtotalUseCase,
    required this.incrementCartItemUseCase,
    required this.decrementCartItemUseCase,
    required this.removeFromCartUseCase,
    required this.clearLocalCartUseCase,
  }) : super(const CartState()) {
    // Listen to auth changes so the cart automatically switches between guest and authenticated user
    _authSubscription = auth.authStateChanges().listen((_) {
      fetchCartData();
    });
    fetchCartData();
  }

  final FirebaseAuth auth;
  final GetCartItemsUseCase getCartItemsUseCase;
  final AddToCartUseCase addToCartUseCase;
  final CalculateSubtotalUseCase calculateSubtotalUseCase;
  final IncrementCartItemUseCase incrementCartItemUseCase;
  final DecrementCartItemUseCase decrementCartItemUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final ClearLocalCartUseCase clearLocalCartUseCase;

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  void clearUserMessage() {
    emit(state.copyWith(resetUserMessage: true));
  }

  Future<void> fetchCartData() async {
    emit(state.copyWith(status: CartStatus.loading, resetUserMessage: true));
    final userId = auth.currentUser?.uid;
    final result = await getCartItemsUseCase.call(userId: userId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CartStatus.error,
            errorMessage: failure.message,
            cartItemsWithProducts: const [],
          ),
        );
      },
      (items) {
        emit(
          state.copyWith(
            cartItemsWithProducts: items,
            status: CartStatus.loaded,
          ),
        );
        _calculateSubtotal();
      },
    );
  }

  Future<void> addToCart({
    required CartItemEntity cartItem,
    required ProductEntity product,
    int? stock,
  }) async {
    // Find existing item in this user's cart
    CartItemWithProductEntity? existingItem;

    for (final item in state.cartItemsWithProducts) {
      if (item.item.productId == cartItem.productId &&
          item.item.variantId == cartItem.variantId &&
          item.item.size == cartItem.size) {
        existingItem = item;
        break;
      }
    }

    final inCartQuantity = existingItem?.item.quantity ?? 0;
    int quantityToAdd = cartItem.quantity;
    bool isPartial = false;

    // Check available stock
    if (stock != null) {
      final remainingStock = stock - inCartQuantity;

      if (remainingStock <= 0) {
        emit(
          state.copyWith(
            userMessage: 'No remaining stock available for this item.',
          ),
        );
        return;
      }

      if (quantityToAdd > remainingStock) {
        quantityToAdd = remainingStock;
        isPartial = true;
      }
    }

    // Create CartItemModel with allowed quantity
    final itemModel = cartItem is CartItemModel
        ? (cartItem.quantity == quantityToAdd
              ? cartItem
              : cartItem.copyWith(quantity: quantityToAdd))
        : CartItemModel(
            productId: cartItem.productId,
            variantId: cartItem.variantId,
            size: cartItem.size,
            quantity: quantityToAdd,
          );

    emit(state.copyWith(status: CartStatus.loading, resetUserMessage: true));

    final userId = auth.currentUser?.uid;
    final result = await addToCartUseCase.call(item: itemModel, userId: userId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CartStatus.error,
            errorMessage: failure.message,
            userMessage: failure.message,
          ),
        );
      },
      (_) {
        final existingIndex = state.cartItemsWithProducts.indexWhere(
          (item) =>
              item.item.productId == itemModel.productId &&
              item.item.variantId == itemModel.variantId &&
              item.item.size == itemModel.size,
        );

        List<CartItemWithProductEntity> updatedItems;

        if (existingIndex != -1) {
          final existing = state.cartItemsWithProducts[existingIndex];

          updatedItems = List<CartItemWithProductEntity>.from(
            state.cartItemsWithProducts,
          );

          updatedItems[existingIndex] = CartItemWithProductEntity(
            item: CartItemModel(
              productId: existing.item.productId,
              variantId: existing.item.variantId,
              size: existing.item.size,
              quantity: existing.item.quantity + itemModel.quantity,
            ),
            product: existing.product,
          );
        } else {
          updatedItems = [
            ...state.cartItemsWithProducts,
            CartItemWithProductEntity(item: itemModel, product: product),
          ];
        }

        final successMessage = isPartial
            ? 'Only $quantityToAdd available in stock. Added $quantityToAdd to cart.'
            : 'Added $quantityToAdd item(s) to cart.';

        emit(
          state.copyWith(
            status: CartStatus.loaded,
            cartItemsWithProducts: updatedItems,
            userMessage: successMessage,
          ),
        );
        _calculateSubtotal();
      },
    );
  }

  void _calculateSubtotal() {
    final subtotal = calculateSubtotalUseCase.call(state.cartItemsWithProducts);
    emit(state.copyWith(subtotal: subtotal));
  }

  Future<void> incrementItem(
    CartItemWithProductEntity cartItemWithProduct,
  ) async {
    final itemId = cartItemWithProduct.item.id;
    final userId = auth.currentUser?.uid;

    if (!cartItemWithProduct.canIncrement) {
      return;
    }

    // Optimistic update
    final updatedItems = state.cartItemsWithProducts.map((e) {
      if (e.item.id == itemId) {
        return CartItemWithProductEntity(
          product: e.product,
          item: CartItemModel(
            productId: e.item.productId,
            variantId: e.item.variantId,
            size: e.item.size,
            quantity: e.item.quantity + 1,
          ),
        );
      }
      return e;
    }).toList();

    emit(state.copyWith(cartItemsWithProducts: updatedItems));
    _calculateSubtotal();

    final result = await incrementCartItemUseCase.call(
      itemId: itemId,
      userId: userId,
    );
    result.fold((failure) {
      emit(
        state.copyWith(status: CartStatus.error, errorMessage: failure.message),
      );
      fetchCartData();
    }, (_) {});
  }

  Future<void> decrementItem(
    CartItemWithProductEntity cartItemWithProduct,
  ) async {
    final itemId = cartItemWithProduct.item.id;
    final userId = auth.currentUser?.uid;

    if (!cartItemWithProduct.canDecrement) {
      return;
    }

    // Optimistic update
    final updatedItems = state.cartItemsWithProducts.map((e) {
      if (e.item.id == itemId) {
        return CartItemWithProductEntity(
          product: e.product,
          item: CartItemModel(
            productId: e.item.productId,
            variantId: e.item.variantId,
            size: e.item.size,
            quantity: e.item.quantity - 1,
          ),
        );
      }
      return e;
    }).toList();

    emit(state.copyWith(cartItemsWithProducts: updatedItems));
    _calculateSubtotal();

    final result = await decrementCartItemUseCase.call(
      itemId: itemId,
      userId: userId,
    );
    result.fold((failure) {
      emit(
        state.copyWith(status: CartStatus.error, errorMessage: failure.message),
      );
      fetchCartData();
    }, (_) {});
  }

  Future<void> removeItem(CartItemWithProductEntity cartItemWithProduct) async {
    final itemId = cartItemWithProduct.item.id;
    final userId = auth.currentUser?.uid;

    // Optimistic update
    final updatedItems = state.cartItemsWithProducts
        .where((e) => e.item.id != itemId)
        .toList();

    emit(state.copyWith(cartItemsWithProducts: updatedItems));
    _calculateSubtotal();

    final result = await removeFromCartUseCase.call(
      itemId: itemId,
      userId: userId,
    );
    result.fold((failure) {
      emit(
        state.copyWith(status: CartStatus.error, errorMessage: failure.message),
      );
      fetchCartData();
    }, (_) {});
  }

  Future<void> syncLocalCart() async {
    final result = await getCartItemsUseCase();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CartStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (localCartItems) {
        if (localCartItems.isNotEmpty) {
          for (final localItem in localCartItems) {
            addToCart(cartItem: localItem.item, product: localItem.product);
          }
          clearLocalCartUseCase.call();
        }
      },
    );
  }
}
