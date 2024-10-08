import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  veganFree,
  lactoseFree,
  vegetarianFree
}

class FiltersNotifer extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifer() : super({
    Filter.glutenFree : false,
    Filter.lactoseFree : false,
    Filter.veganFree : false,
    Filter.vegetarianFree : false,
  });

  void setFilter(Filter filter, bool isActive){
    state = {
      ...state,
      filter:isActive,
    };
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifer, Map<Filter, bool>>((ref) {
  return FiltersNotifer();
});

final filteredMealsProvider = Provider((ref){
final meals = ref.watch(mealsProvider);
final activeFilters = ref.watch(filtersProvider);

return meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.veganFree]! && !meal.isVegan) {
        return false;
      }
      if (activeFilters[Filter.vegetarianFree]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      return true;
    }).toList();
});