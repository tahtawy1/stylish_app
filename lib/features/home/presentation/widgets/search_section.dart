import 'package:flutter/material.dart';
import 'package:stylish_app/features/home/presentation/widgets/filter_button.dart';
import 'package:stylish_app/features/home/presentation/widgets/search_bar_widget.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key, this.onSearchChanged, this.onFilterTap});

  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SearchBarWidget()),
        const SizedBox(width: 12),
        FilterButton(onTap: onFilterTap),
      ],
    );
  }
}
