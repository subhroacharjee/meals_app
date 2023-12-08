import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/src/providers/meals_provider.dart';
import 'package:meals_app/src/screens/filters.dart';

class FiltersNotifer extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifer()
      : super({
          Filter.veg: false,
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> map) {
    state = map;
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifer, Map<Filter, bool>>((ref) => FiltersNotifer());

final filteredMealProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final selectedFilters = ref.watch(filterProvider);
  final availableMeals = meals.where((meal) {
    if (selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) return false;
    if (selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
    if (selectedFilters[Filter.veg]! && !meal.isVegetarian) return false;
    return true;
  }).toList();
  return availableMeals;
});
