import 'package:flutter/material.dart';
import 'package:stylish_app/features/home/data/data_sources/home_dummy_data.dart';
import 'package:stylish_app/features/home/presentation/widgets/category_tag_item.dart';

class TagsSection extends StatefulWidget {
  const TagsSection({
    super.key,
    this.onCategorySelected,
  });

  final ValueChanged<String>? onCategorySelected;

  @override
  State<TagsSection> createState() => _TagsSectionState();
}

class _TagsSectionState extends State<TagsSection> {
  String selectedCategoryId = '1';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: HomeDummyData.categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = HomeDummyData.categories[index];
          final isSelected = category.id == selectedCategoryId;
          return CategoryTagItem(
            label: category.label,
            icon: category.icon,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                selectedCategoryId = category.id;
              });
              widget.onCategorySelected?.call(category.id);
            },
          );
        },
      ),
    );
  }
}
