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

class _CategoriesScreenState extends ConsumerState<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(filteredMealProvider);
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (ctx, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0.9, 0.9),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.decelerate),
        ),
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
