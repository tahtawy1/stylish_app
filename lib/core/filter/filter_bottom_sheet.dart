import 'package:flutter/material.dart';
import 'package:stylish_app/features/product/domain/entities/product_filter_model.dart';
import 'package:stylish_app/features/product/presentation/widgets/product_filter_sheet.dart';

export 'package:stylish_app/features/product/presentation/widgets/product_filter_sheet.dart';

Future<ProductFilterModel?> showFilterBottomSheet(
  BuildContext context, {
  ProductFilterModel? initialFilter,
}) {
  return ProductFilterSheet.show(context, initialFilter: initialFilter);
}
