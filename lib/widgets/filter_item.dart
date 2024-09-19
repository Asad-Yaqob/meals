import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({super.key, required this.isChecked, required this.onChanged, required this.title});

  final String title;
  final bool isChecked;
  final Function(bool isChecked) onChanged;

  @override
  Widget build(BuildContext context) {
    return  SwitchListTile(
            value: isChecked,
            onChanged: onChanged,
            title: Text(
              '$title ',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            subtitle: Text(
              'Includes $title meals only.',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          );
  }
}