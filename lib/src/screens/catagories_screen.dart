import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/src/components/category_button.dart';
import 'package:meals_app/src/data/dummy_data.dart';
import 'package:meals_app/src/providers/filters_provider.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});
  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(filteredMealProvider);
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      children: availableCategories
          .map<Widget>(
            (val) => CategoryButton(
              category: val,
              meals: meals,
            ),
          )
          .toList(),
    );
  }
}
