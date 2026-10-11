import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('My Cart', style: context.textStyle.headlineMedium),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 16),
          child: GestureDetector(
            onTap: () {
              // TODO: show cart options menu
            },
            child: Icon(
              Icons.more_horiz_rounded,
              size: 24,
              color: context.colors.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
