import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

// const kInitializerFilters = {
//   Filter.glutenFree: false,
//   Filter.lactoseFree: false,
//   Filter.veganFree: false,
//   Filter.vegetarianFree: false
// };

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> favoriteMeals = [];

  // Map<Filter, bool> selectedFilters = kInitializerFilters;

  // void manageFavoriteMeals(Meal meal) {
  //   final isFavorite = favoriteMeals.contains(meal);
  //   if (isFavorite) {
  //     setState(() {
  //       favoriteMeals.remove(meal);
  //     });
  //     showInfoMessage('Meal is removed from favorites!.');
  //   } else {
  //     setState(() {
  //       favoriteMeals.add(meal);
  //     });
  //     showInfoMessage('Meal is added to favorites!.');
  //   }
  // }

  void _selectedIndexChange(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'meals') {
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const TabsScreen()));
    }

    if (identifier == 'filters') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    var selectedPageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
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
