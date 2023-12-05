import 'package:flutter/material.dart';
import 'package:meals_app/src/components/main_drawer.dart';
import 'package:meals_app/src/data/dummy_data.dart';
import 'package:meals_app/src/screens/catagories_screen.dart';
import 'package:meals_app/src/screens/meals_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _title = "Categories";
  int _selectedIndex = 0;
  Widget _content = const CategoriesScreen();

  void _changeScreen(int idx) {
    setState(() {
      _title = idx == 0 ? "Categories" : "Favorties";
      _content = idx == 0
          ? const CategoriesScreen()
          : MealsScreen(
              meals: dummyMeals.where((meal) => meal.isFavorite).toList(),
              changeState: () => {_changeScreen(idx)},
            );
      _selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      drawer: MainDrawer(),
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
