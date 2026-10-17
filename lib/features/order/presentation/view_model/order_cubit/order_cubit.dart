import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/core/error/failure.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/order/domain/entities/order_entity.dart';
import 'package:stylish_app/features/order/domain/use_cases/create_order_use_case.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final CreateOrderUseCase createOrderUseCase;
  final FirebaseAuth auth;

  OrderCubit({
    required this.createOrderUseCase,
    required this.auth,
  }) : super(const OrderInitial());

  Future<void> placeOrder({
    required List<CartItemWithProductEntity> cartItems,
    double shippingFee = 80.0,
  }) async {
    // Prevent duplicate taps
    if (state is OrderLoading) return;

    final user = auth.currentUser;
    if (user == null) {
      emit(
        const OrderError(
          failure: AuthFailure(
            code: 'unauthenticated',
            message: 'Please login to place an order.',
          ),
        ),
      );
      return;
    }

    if (cartItems.isEmpty) {
      emit(
        const OrderError(
          failure: ServerFailure(message: 'Your cart is empty.'),
        ),
      );
      return;
    }

    emit(const OrderLoading());

    final result = await createOrderUseCase.call(
      userId: user.uid,
      cartItems: cartItems,
      shippingFee: shippingFee,
    );

    result.fold(
      (failure) => emit(OrderError(failure: failure)),
      (order) => emit(OrderSuccess(order: order)),
    );
  }

  void reset() {
    emit(const OrderInitial());
  }
}
