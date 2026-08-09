import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

/// Horizontal divider with a centred label ("Or") shared by login & register.
class AuthOrDivider extends StatelessWidget {
  const AuthOrDivider({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: context.colors.outline)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: context.textStyle.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: Divider(color: context.colors.outline)),
      ],
    );
  }
}
