import 'package:flutter/material.dart';
import 'package:meals_app/src/data/dummy_data.dart';
import 'package:meals_app/src/model/category.dart';
import 'package:meals_app/src/screens/meals_screen.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.category,
  });
  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MealsScreen(
              title: category.title,
              meals: dummyMeals
                  .where(
                    (meal) => meal.categories.any((categoryId) => categoryId == category.id),
                  )
                  .toList(),
              changeState: () {},
            ),
          ),
        );
      },
      splashColor: Theme.of(context).splashColor,
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: category.color,
        child: Center(
          child: Text(
            category.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
