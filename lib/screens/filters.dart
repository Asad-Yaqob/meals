import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/widgets/filter_item.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersProvider);
    final filterNotifier = ref.read(filtersProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          for (final filter in filters.keys)
            FilterItem(
                isChecked: filters[filter]!,
                onChanged: (isChecked) =>
                    filterNotifier.setFilter(filter, isChecked),
                title: filter.toString().split('.').last)
        ],
      ),
    );
  }
}
