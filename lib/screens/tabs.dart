import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitializerFilters = {
  "Gluten Free": false,
  "Vegan Free": false,
  "Vegetarian Free": false,
  "Lactose Free": false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> favoriteMeals = [];

  Map<String, bool> selectedFilters = kInitializerFilters;

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void manageFavoriteMeals(Meal meal) {
    final isFavorite = favoriteMeals.contains(meal);
    if (isFavorite) {
      setState(() {
        favoriteMeals.remove(meal);
      });
      showInfoMessage('Meal is removed from favorites!.');
    } else {
      setState(() {
        favoriteMeals.add(meal);
      });
      showInfoMessage('Meal is added to favorites!.');
    }
  }

  void _selectedIndexChange(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.push<Map<String, bool>>(
        context,
        MaterialPageRoute(
            builder: (ctx) => FiltersScreen(
                  currentFilters: selectedFilters,
                )),
      );

      setState(() {
        selectedFilters = result ?? kInitializerFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (selectedFilters["Gluten Free"]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters["Vegan Free"]! && !meal.isVegan) {
        return false;
      }
      if (selectedFilters["Vegetarian Free"]! && !meal.isVegetarian) {
        return false;
      }
      if (selectedFilters["Lactose Free"]! && !meal.isLactoseFree) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
      onToggleFavorite: manageFavoriteMeals,
    );
    
    var selectedPageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favoriteMeals,
        onToggleFavorite: manageFavoriteMeals,
      );
      selectedPageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedIndexChange,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
          ]),
    );
  }
}
