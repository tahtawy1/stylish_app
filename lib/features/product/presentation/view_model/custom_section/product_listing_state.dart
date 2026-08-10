part of 'product_listing_cubit.dart';

enum ProductListingStatus { initial, loading, success, failure }

class ProductListingState {
  final ProductListingStatus status;
  final ProductListingType? type;
  final List<ProductEntity>? products;
  final String? categoryId;
  final String? categoryName;
  final bool hasMore;
  final DocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final bool isLoadingMore;
  final String? errorMessage;

  const ProductListingState({
    this.status = ProductListingStatus.initial,
    this.type,
    this.categoryId,
    this.categoryName,
    this.products = const [],
    this.hasMore = true,
    this.lastDocument,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  ProductListingState copyWith({
    ProductListingStatus? status,
    ProductListingType? type,
    String? categoryId,
    String? categoryName,
    List<ProductEntity>? products,
    bool? hasMore,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    bool? isLoadingMore,
    String? errorMessage,
  }) {
    return ProductListingState(
      status: status ?? this.status,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      products: products ?? this.products,
      hasMore: hasMore ?? this.hasMore,
      lastDocument: lastDocument ?? this.lastDocument,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
