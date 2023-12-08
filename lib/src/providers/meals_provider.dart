import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/src/data/dummy_data.dart';
import 'package:meals_app/src/model/meals.dart';

class MealsNotifier extends StateNotifier<List<Meal>> {
  MealsNotifier() : super(dummyMeals);

  void toggleMealAsFavorite(Meal meal) {
    state = state.map((ml) {
      if (ml.id == meal.id) {
        meal.isFavorite = !meal.isFavorite;
        return meal;
      }
      return ml;
    }).toList();
  }
}

final mealsProvider = StateNotifierProvider<MealsNotifier, List<Meal>>((ref) {
  return MealsNotifier();
});
