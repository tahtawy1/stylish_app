enum ProductSortOption {
  priceLowToHigh,
  priceHighToLow;

  String get label {
    switch (this) {
      case ProductSortOption.priceLowToHigh:
        return 'Price: Low – High';
      case ProductSortOption.priceHighToLow:
        return 'Price: High – Low';
    }
  }
}

class ProductFilterModel {
  final double? minPrice;
  final double? maxPrice;
  final bool ratingFourAndAbove;
  final ProductSortOption? sortOption;

  const ProductFilterModel({
    this.minPrice,
    this.maxPrice,
    this.ratingFourAndAbove = false,
    this.sortOption,
  });

  bool get hasActiveFilter =>
      minPrice != null ||
      maxPrice != null ||
      ratingFourAndAbove ||
      sortOption != null;

  ProductFilterModel copyWith({
    Object? minPrice = _unset,
    Object? maxPrice = _unset,
    bool? ratingFourAndAbove,
    Object? sortOption = _unset,
  }) {
    return ProductFilterModel(
      minPrice: identical(minPrice, _unset)
          ? this.minPrice
          : minPrice as double?,
      maxPrice: identical(maxPrice, _unset)
          ? this.maxPrice
          : maxPrice as double?,
      ratingFourAndAbove: ratingFourAndAbove ?? this.ratingFourAndAbove,
      sortOption: identical(sortOption, _unset)
          ? this.sortOption
          : sortOption as ProductSortOption?,
    );
  }
}

const _unset = Object();
