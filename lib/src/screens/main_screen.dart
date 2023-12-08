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

  void _onDrawerPressed(String identifier) {
    Navigator.pop(context);
    if (identifier == "filters") {
      Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
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

    _content = const CategoriesScreen();
    _title = "Categories";

    if (_selectedIndex == 1) {
      _content = MealsScreen(
        meals: meals.where((meal) => meal.isFavorite).toList(),
      );
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
