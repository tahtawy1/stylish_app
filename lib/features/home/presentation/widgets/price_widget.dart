import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.price,
    this.isOldPrice = false,
    this.isNewPrice = false,
  });
  final bool isOldPrice;
  final bool isNewPrice;

  final double price;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FittedBox(
        child: Text(
          '${context.l10n.poundSymbol} ${price.toStringAsFixed(2)}',
          style: isOldPrice
              ? context.textStyle.bodySmall?.copyWith(
                  fontSize: 13,
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.w900,
                )
              : context.textStyle.bodyMedium?.copyWith(
                  fontSize: 15,
                  color: isNewPrice
                      ? context.colors.error
                      : context.colors.primary,
                  fontWeight: FontWeight.w900,
                ),
        ),
      ),
    );
  }
}
