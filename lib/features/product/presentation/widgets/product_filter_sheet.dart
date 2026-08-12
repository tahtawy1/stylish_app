import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/widgets/app_button.dart';
import 'package:stylish_app/features/product/domain/entities/product_filter_model.dart';

class ProductFilterSheet extends StatefulWidget {
  const ProductFilterSheet({super.key, this.initialFilter});

  final ProductFilterModel? initialFilter;

  static Future<ProductFilterModel?> show(
    BuildContext context, {
    ProductFilterModel? initialFilter,
  }) {
    return showModalBottomSheet<ProductFilterModel?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ProductFilterSheet(initialFilter: initialFilter),
    );
  }

  @override
  State<ProductFilterSheet> createState() => _ProductFilterSheetState();
}

class _ProductFilterSheetState extends State<ProductFilterSheet> {
  ProductSortOption? _selectedSort;
  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;
  bool _ratingFourAndAbove = false;

  @override
  void initState() {
    super.initState();
    final filter = widget.initialFilter;
    _selectedSort = filter?.sortOption;
    _minPriceController = TextEditingController(
      text: filter?.minPrice != null
          ? filter!.minPrice!.toStringAsFixed(0)
          : '',
    );
    _maxPriceController = TextEditingController(
      text: filter?.maxPrice != null
          ? filter!.maxPrice!.toStringAsFixed(0)
          : '',
    );
    _ratingFourAndAbove = filter?.ratingFourAndAbove ?? false;
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _onClear() {
    setState(() {
      _selectedSort = null;
      _minPriceController.clear();
      _maxPriceController.clear();
      _ratingFourAndAbove = false;
    });
    Navigator.pop(context, const ProductFilterModel());
  }

  void _onApply() {
    final minText = _minPriceController.text.trim();
    final maxText = _maxPriceController.text.trim();

    final minPrice = double.tryParse(minText);
    final maxPrice = double.tryParse(maxText);

    if (minPrice != null && maxPrice != null && minPrice > maxPrice) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Minimum price cannot be greater than maximum price.'),
        ),
      );
      return;
    }

    final filter = ProductFilterModel(
      minPrice: minPrice,
      maxPrice: maxPrice,
      ratingFourAndAbove: _ratingFourAndAbove,
      sortOption: _selectedSort,
    );

    Navigator.pop(context, filter);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.colors.outline.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title Header Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filters',
                      style: context.textStyle.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: _onClear,
                          child: Text(
                            'Clear All',
                            style: context.textStyle.bodyMedium?.copyWith(
                              color: context.colors.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close_rounded),
                          splashRadius: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(height: 24),
              ),

              // 1. Sort By
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Sort By',
                  style: context.textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    _SortChip(
                      label: 'Relevance',
                      isSelected: _selectedSort == null,
                      onSelected: () {
                        setState(() => _selectedSort = null);
                      },
                    ),
                    const SizedBox(width: 8),
                    _SortChip(
                      label: ProductSortOption.priceLowToHigh.label,
                      isSelected:
                          _selectedSort == ProductSortOption.priceLowToHigh,
                      onSelected: () {
                        setState(
                          () =>
                              _selectedSort = ProductSortOption.priceLowToHigh,
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    _SortChip(
                      label: ProductSortOption.priceHighToLow.label,
                      isSelected:
                          _selectedSort == ProductSortOption.priceHighToLow,
                      onSelected: () {
                        setState(
                          () =>
                              _selectedSort = ProductSortOption.priceHighToLow,
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(height: 32),
              ),

              // 2. Price Range
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Price Range',
                  style: context.textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _minPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Min Price',
                          prefixText: '\$ ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('–', style: TextStyle(fontSize: 18)),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _maxPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Max Price',
                          prefixText: '\$ ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(height: 32),
              ),

              // 3. Rating
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Rating',
                  style: context.textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: FilterChip(
                  showCheckmark: false,
                  avatar: Icon(
                    Icons.star_rounded,
                    size: 20,
                    color: _ratingFourAndAbove
                        ? context.colors.onPrimary
                        : Colors.amber,
                  ),
                  label: const Text('4★ and above'),
                  selected: _ratingFourAndAbove,
                  selectedColor: context.colors.primary,
                  labelStyle: TextStyle(
                    color: _ratingFourAndAbove
                        ? context.colors.onPrimary
                        : context.colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSelected: (selected) {
                    setState(() => _ratingFourAndAbove = selected);
                  },
                ),
              ),
              const SizedBox(height: 32),

              // 4. Apply Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AppButton(title: 'Apply Filters', onPressed: _onApply),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: context.colors.primary,
      backgroundColor: context.colors.surface,
      labelStyle: TextStyle(
        color: isSelected ? context.colors.onPrimary : context.colors.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? context.colors.primary : context.colors.outline,
        ),
      ),
    );
  }
}
