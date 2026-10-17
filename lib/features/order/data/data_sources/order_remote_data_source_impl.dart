import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stylish_app/core/error/exceptions.dart';
import 'package:stylish_app/features/cart/domain/entities/cart_item_with_product_entity.dart';
import 'package:stylish_app/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:stylish_app/features/order/data/models/order_item_model.dart';
import 'package:stylish_app/features/order/data/models/order_model.dart';
import 'package:stylish_app/features/product/data/models/product_model.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore firestore;

  OrderRemoteDataSourceImpl({required this.firestore});

  @override
  Future<OrderModel> createOrder({
    required String userId,
    required List<CartItemWithProductEntity> cartItems,
    double shippingFee = 80.0,
  }) async {
    if (userId.isEmpty) {
      throw const AuthException(
        code: 'unauthenticated',
        message: 'User is not authenticated.',
      );
    }

    if (cartItems.isEmpty) {
      throw const ServerException(message: 'Cart is empty.');
    }

    // Pre-generate order reference so the orderId is stable across transaction retries
    final orderDocRef = firestore.collection('my_orders').doc();
    final orderId = orderDocRef.id;

    // Aggregate requested quantities by (productId, variantId, size)
    final Map<String, int> aggregatedQuantities = {};
    for (final item in cartItems) {
      final key =
          '${item.item.productId}|${item.item.variantId}|${item.item.size}';
      aggregatedQuantities[key] =
          (aggregatedQuantities[key] ?? 0) + item.item.quantity;
    }

    final uniqueProductIds =
        cartItems.map((e) => e.item.productId).toSet().toList();

    late OrderModel createdOrder;

    try {
      await firestore.runTransaction((transaction) async {
        // ================= 1. READ PHASE =================
        // Must read all documents first before any writes
        final Map<String, DocumentSnapshot<Map<String, dynamic>>>
        productSnapshots = {};
        for (final productId in uniqueProductIds) {
          final docRef = firestore.collection('products').doc(productId);
          final snapshot = await transaction.get(docRef);
          if (!snapshot.exists || snapshot.data() == null) {
            throw ServerException(
              message: 'Product with ID $productId was not found.',
            );
          }
          productSnapshots[productId] = snapshot;
        }

        // ================= 2. VALIDATION PHASE =================
        final Map<String, Map<String, dynamic>> productUpdates = {};
        final List<OrderItemModel> verifiedItems = [];
        double calculatedSubtotal = 0.0;

        for (final productId in uniqueProductIds) {
          final snapshot = productSnapshots[productId]!;
          final productData = Map<String, dynamic>.from(snapshot.data()!);
          final product = ProductModel.fromJson(productData);

          if (!product.isAvailable) {
            throw InsufficientStockException(
              productTitle: product.title,
              message: 'Product "${product.title}" is currently unavailable.',
            );
          }

          final colorVariants = (productData['colorVariants']
                  as List<dynamic>? ??
              [])
              .map((cv) => Map<String, dynamic>.from(cv as Map<String, dynamic>))
              .toList();

          int productTotalDeducted = 0;

          // Process cart items matching this product
          final itemsForProduct =
              cartItems.where((e) => e.item.productId == productId).toList();

          for (final cartItem in itemsForProduct) {
            final variantId = cartItem.item.variantId;
            final size = cartItem.item.size;
            final quantity = cartItem.item.quantity;

            if (quantity <= 0) {
              throw const ServerException(message: 'Invalid item quantity.');
            }

            final variantIndex =
                colorVariants.indexWhere((v) => v['id'] == variantId);
            if (variantIndex == -1) {
              throw InsufficientStockException(
                productTitle: product.title,
                message: 'Selected color variant is unavailable.',
              );
            }

            final variant = colorVariants[variantIndex];
            final sizes = (variant['sizes'] as List<dynamic>? ?? [])
                .map((s) => Map<String, dynamic>.from(s as Map<String, dynamic>))
                .toList();

            final sizeIndex = sizes.indexWhere((s) => s['size'] == size);
            if (sizeIndex == -1) {
              throw InsufficientStockException(
                productTitle: product.title,
                message: 'Selected size "$size" is unavailable.',
              );
            }

            final sizeData = sizes[sizeIndex];
            final currentStock = (sizeData['quantity'] as num?)?.toInt() ?? 0;
            final isSizeAvailable = sizeData['isAvailable'] as bool? ?? true;

            // Check against the aggregated quantity for this stock item
            final totalRequested =
                aggregatedQuantities['$productId|$variantId|$size'] ?? quantity;

            if (!isSizeAvailable || currentStock < totalRequested) {
              throw InsufficientStockException(
                productTitle: product.title,
                message:
                    'Insufficient stock for "${product.title}" (Size $size).',
              );
            }

            // Deduct stock for this cart item
            final newStock = currentStock - quantity;
            sizeData['quantity'] = newStock;
            if (newStock <= 0) {
              sizeData['isAvailable'] = false;
            }
            sizes[sizeIndex] = sizeData;
            variant['sizes'] = sizes;
            colorVariants[variantIndex] = variant;

            productTotalDeducted += quantity;

            // Verified server price
            final unitPrice = product.finalPrice;
            final itemTotal = unitPrice * quantity;
            calculatedSubtotal += itemTotal;

            final imageUrl = (variant['images'] as List<dynamic>?)
                    ?.firstOrNull as String? ??
                product.images.firstOrNull ??
                '';

            verifiedItems.add(
              OrderItemModel(
                productId: productId,
                productTitle: product.title,
                imageUrl: imageUrl,
                variantId: variantId,
                color: variant['color'] as String? ?? '',
                size: size,
                unitPrice: unitPrice,
                quantity: quantity,
                totalPrice: itemTotal,
              ),
            );
          }

          productData['colorVariants'] = colorVariants;
          productData['totalSales'] =
              product.totalSales + productTotalDeducted;
          productData['updatedAt'] = FieldValue.serverTimestamp();
          productUpdates[productId] = productData;
        }

        // ================= 3. WRITE PHASE =================
        // Deduct stock on each product
        for (final productId in uniqueProductIds) {
          final docRef = firestore.collection('products').doc(productId);
          transaction.update(docRef, productUpdates[productId]!);
        }

        // Create the order model
        createdOrder = OrderModel(
          orderId: orderId,
          userId: userId,
          items: verifiedItems,
          subtotal: calculatedSubtotal,
          shippingFee: shippingFee,
          totalPrice: calculatedSubtotal + shippingFee,
          status: 'pending',
          createdAt: DateTime.now(),
        );

        // Commit order doc in same transaction
        transaction.set(orderDocRef, createdOrder.toJson());
      });

      // ================= 4. POST-TRANSACTION CLEANUP =================
      // Clear remote cart in Firestore only after transaction succeeds
      await _clearRemoteCart(userId);

      return createdOrder;
    } on AppException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> _clearRemoteCart(String userId) async {
    try {
      final cartSnap = await firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      if (cartSnap.docs.isNotEmpty) {
        final batch = firestore.batch();
        for (final doc in cartSnap.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();
      }
    } catch (_) {
      // Non-critical if remote cart clean fails after order creation
    }
  }

  @override
  Future<List<OrderModel>> getMyOrders({required String userId}) async {
    try {
      final snapshot = await firestore
          .collection('my_orders')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
