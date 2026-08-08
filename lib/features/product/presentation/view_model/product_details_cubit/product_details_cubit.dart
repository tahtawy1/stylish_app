import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/features/product/domain/entities/color_variant_entity.dart';
import 'package:stylish_app/features/product/domain/entities/product_entity.dart';
import 'package:stylish_app/features/product/domain/entities/size_variant_entity.dart';
import 'package:stylish_app/features/product/domain/use_cases/get_product_by_id.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit({required this.getProductByIdUseCase})
    : super(const ProductDetailsState());

  final GetProductByIdUseCase getProductByIdUseCase;

  Future<void> load({required String id}) async {
    if (isClosed) return;

    emit(state.copyWith(status: ProductDetailsStatus.loading));

    final result = await getProductByIdUseCase.call(id: id);

    if (isClosed) return;

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(
          state.copyWith(
            status: ProductDetailsStatus.failure,
            errorMessage: failure.message,
          ),
        );
        log(failure.message);
      },
      (product) {
        if (isClosed) return;

        final colorVariants = product.colorVariants;

        final ColorVariantEntity? selectedColorVariant =
            colorVariants.isNotEmpty ? colorVariants.first : null;

        final images = selectedColorVariant == null
            ? product.images
            : selectedColorVariant.images.isNotEmpty
            ? selectedColorVariant.images
            : product.images;

        emit(
          state.copyWith(
            status: ProductDetailsStatus.success,
            product: product,
            colorVariants: colorVariants,
            selectedColorVariant: selectedColorVariant,
            images: images,
          ),
        );
      },
    );
  }

  void selectColorVariant(ColorVariantEntity colorVariant) {
    if (isClosed) return;
    final product = state.product;
    final images = colorVariant.images.isNotEmpty
        ? colorVariant.images
        : (product?.images ?? []);

    emit(
      state.copyWith(
        selectedColorVariant: colorVariant,
        selectedSizeVariant: null,
        images: images,
      ),
    );
  }

  void selectSizeVariant(SizeVariantEntity sizeVariant) {
    if (isClosed) return;
    emit(state.copyWith(selectedSizeVariant: sizeVariant));
  }
}
