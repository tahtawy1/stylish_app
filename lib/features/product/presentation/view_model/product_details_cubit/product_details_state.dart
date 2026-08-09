part of 'product_details_cubit.dart';

enum ProductDetailsStatus { initial, loading, success, failure }

@immutable
class ProductDetailsState {
  final ProductDetailsStatus status;
  final ProductEntity? product;
  final List<ColorVariantEntity>? colorVariants;
  final ColorVariantEntity? selectedColorVariant;
  final SizeVariantEntity? selectedSizeVariant;
  final List<String>? images;
  final bool isFavorite;
  final String? errorMessage;

  const ProductDetailsState({
    this.status = ProductDetailsStatus.initial,
    this.product,
    this.colorVariants,
    this.selectedColorVariant,
    this.selectedSizeVariant,
    this.images,
    this.isFavorite = false,
    this.errorMessage,
  });

  List<SizeVariantEntity> get availableSizes =>
      selectedColorVariant?.sizes ?? [];

  ProductDetailsState copyWith({
    ProductDetailsStatus? status,
    ProductEntity? product,
    List<ColorVariantEntity>? colorVariants,
    ColorVariantEntity? selectedColorVariant,
    // null means "clear the selected size" — use a sentinel to distinguish
    // "not provided" from "explicitly set to null"
    Object? selectedSizeVariant = _keep,
    List<String>? images,
    bool? isFavorite,
    String? errorMessage,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      product: product ?? this.product,
      colorVariants: colorVariants ?? this.colorVariants,
      selectedColorVariant: selectedColorVariant ?? this.selectedColorVariant,
      selectedSizeVariant: selectedSizeVariant == _keep
          ? this.selectedSizeVariant
          : selectedSizeVariant as SizeVariantEntity?,
      images: images ?? this.images,
      isFavorite: isFavorite ?? this.isFavorite,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

const _keep = Object();
