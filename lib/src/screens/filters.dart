import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  veg,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.filters});

  final Map<Filter, bool> filters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          return Navigator.of(context).pop(widget.filters);
        },
        child: Column(children: [
          SwitchListTile(
            value: widget.filters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              setState(() {
                widget.filters[Filter.glutenFree] = isChecked;
              });
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
            value: widget.filters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              setState(() {
                widget.filters[Filter.lactoseFree] = isChecked;
              });
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
            value: widget.filters[Filter.veg]!,
            onChanged: (isChecked) {
              setState(() {
                widget.filters[Filter.veg] = isChecked;
              });
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
      ),
    );
  }
}
