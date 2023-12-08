import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/src/providers/filters_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  veg,
}

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var filters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(children: [
        SwitchListTile(
          value: filters[Filter.glutenFree]!,
          onChanged: (isChecked) {
            ref.read(filterProvider.notifier).setFilter(Filter.glutenFree, isChecked);
          },
          title: Text(
            "Gluten Free",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
          subtitle: Text(
            "Only include gluten-free meals",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white.withOpacity(0.6),
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: filters[Filter.lactoseFree]!,
          onChanged: (isChecked) {
            ref.read(filterProvider.notifier).setFilter(Filter.lactoseFree, isChecked);
          },
          title: Text(
            "Lactose Free",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
          subtitle: Text(
            "Only include lactose-free meals",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white.withOpacity(0.6),
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: filters[Filter.veg]!,
          onChanged: (isChecked) {
            ref.read(filterProvider.notifier).setFilter(Filter.veg, isChecked);
          },
          title: Text(
            "Veg",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
          subtitle: Text(
            "Only include veh meals",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white.withOpacity(0.6),
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        )
      ]),
    );
  }
}
