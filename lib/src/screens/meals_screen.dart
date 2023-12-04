import 'package:flutter/material.dart';
import 'package:meals_app/src/components/meal_item.dart';
import 'package:meals_app/src/model/meals.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals, required this.changeState});

  final List<Meal> meals;
  final String? title;
  final void Function() changeState;
  @override
  Widget build(BuildContext context) {
    Widget content = _NoMealsWidget();

    if (meals.isNotEmpty) {
      content = _MealsList(
        meals: meals,
        changeState: changeState,
      );
    }
    if (title == null) return content;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title!,
        ),
      ),
      body: content,
    );
  }
}

class _NoMealsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Oops no meals found for this category!",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
          Text(
            "Try selecting a different category",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );
  }
}

class _MealsList extends StatelessWidget {
  const _MealsList({super.key, required this.meals, required this.changeState});
  final List<Meal> meals;
  final void Function() changeState;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, idx) => MealItem(
          key: ObjectKey(meals[idx].id),
          meal: meals[idx],
          changeState: changeState,
        ),
      ),
    );
  }
}
