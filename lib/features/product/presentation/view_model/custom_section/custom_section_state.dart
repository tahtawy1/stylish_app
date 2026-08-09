part of 'custom_section_cubit.dart';

enum CustomSectionStatus { initial, loading, success, failure }

@immutable
class CustomSectionState {
  final CustomSectionStatus status;
  final CustomSectionType? type;
  final List<ProductEntity>? products;
  final bool hasMore;
  final DocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final bool isLoadingMore;
  final String? errorMessage;

  const CustomSectionState({
    this.status = CustomSectionStatus.initial,
    this.type,
    this.products = const [],
    this.hasMore = true,
    this.lastDocument,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  CustomSectionState copyWith({
    CustomSectionStatus? status,
    CustomSectionType? type,
    List<ProductEntity>? products,
    bool? hasMore,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
    bool? isLoadingMore,
    String? errorMessage,
  }) {
    return CustomSectionState(
      status: status ?? this.status,
      type: type ?? this.type,
      products: products ?? this.products,
      hasMore: hasMore ?? this.hasMore,
      lastDocument: lastDocument ?? this.lastDocument,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
