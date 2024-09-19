import 'package:flutter/material.dart';
import 'package:meals/widgets/filter_item.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<String, bool> currentFilters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Map<String, bool> filters = {
  "Gluten Free": false,
  "Vegan Free": false,
  "Vegetarian Free": false,
  "Lactose Free": false
  };

  @override
  void initState() {
    filters["Gluten Free"] = widget.currentFilters["Gluten Free"]!;
    filters["Vegan Free"] = widget.currentFilters["Vegan Free"]!;
    filters["Vegetarian Free"] = widget.currentFilters["Vegetarian Free"]!;
    filters["Lactose Free"] = widget.currentFilters["Lactose Free"]!;
    super.initState();
  }

  void filterChecked(String filterKey, bool isChecked) {
    setState(() {
      filters[filterKey] = isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;
          Navigator.of(context).pop(filters);
        },
        child: Column(
          children: [
            for (final filter in filters.keys)
              FilterItem(
                  isChecked: filters[filter]!,
                  onChanged: (isChecked) => filterChecked(filter, isChecked),
                  title: filter)
          ],
        ),
      ),
    );
  }
}
