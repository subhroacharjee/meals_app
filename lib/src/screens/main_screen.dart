import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/src/components/main_drawer.dart';
import 'package:meals_app/src/providers/meals_provider.dart';
import 'package:meals_app/src/screens/catagories_screen.dart';
import 'package:meals_app/src/screens/filters.dart';
import 'package:meals_app/src/screens/meals_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  String _title = "Categories";
  int _selectedIndex = 0;
  late Widget _content;
  Map<Filter, bool> _selectedFilters = {
    Filter.veg: false,
    Filter.lactoseFree: false,
    Filter.glutenFree: false,
  };

  void _onDrawerPressed(String identifier) async {
    Navigator.pop(context);
    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            filters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? _selectedFilters;
      });
    }
  }

  void _changeScreen(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) return false;
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
      if (_selectedFilters[Filter.veg]! && !meal.isVegetarian) return false;
      return true;
    }).toList();

    _content = CategoriesScreen(meals: availableMeals);
    _title = "Categories";

    if (_selectedIndex == 1) {
      _content = MealsScreen(
          meals: meals.where((meal) => meal.isFavorite).toList(),
          changeState: () {
            _changeScreen(_selectedIndex);
          });
      _title = "Favorite Meals";
    }
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      drawer: MainDrawer(
        onPressed: _onDrawerPressed,
      ),
      body: _content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changeScreen,
        currentIndex: _selectedIndex,
        items: [
          [Icons.list, "Categories"],
          [Icons.star, "Favorties"],
        ]
            .map(
              (tup) =>
                  BottomNavigationBarItem(icon: Icon(tup[0] as IconData), label: tup[1] as String),
            )
            .toList(),
      ),
    );
  }
}
