import 'package:flutter/material.dart';
import 'package:meals_app/src/components/category_button.dart';
import 'package:meals_app/src/data/dummy_data.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<StatefulWidget> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      children: availableCategories
          .map<Widget>(
            (val) => CategoryButton(category: val),
          )
          .toList(),
    );
  }
}
