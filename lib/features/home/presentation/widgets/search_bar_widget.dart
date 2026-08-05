import 'package:flutter/material.dart';
import 'package:stylish_app/core/extensions/build_context.dart';
import 'package:stylish_app/core/theme/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showSearch(context: context, delegate: _CustomSearch()),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? AppColors.grey1.withAlpha(200)
              : AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: context.isDarkMode ? AppColors.grey3 : AppColors.grey10,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Icon(Icons.search, color: context.colors.onSurfaceVariant),
              const SizedBox(width: 8),
              Text(
                context.l10n.searchHintText,
                style: context.textStyle.bodyMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: context.colors.surface,
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 90,
        titleSpacing: 20,
        leadingWidth: 0,
        backgroundColor: context.colors.surface,
      ),
      iconTheme: IconThemeData(color: context.colors.primary),
      textTheme: TextTheme(
        bodyMedium: TextStyle(fontSize: 17, color: context.colors.primary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: context.isDarkMode ? AppColors.grey3 : AppColors.grey10,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: context.isDarkMode ? AppColors.grey3 : AppColors.grey10,
          ),
        ),
        disabledBorder: InputBorder.none,
        fillColor: context.colors.surface,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox();
  }
}
