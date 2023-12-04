import 'package:flutter/material.dart';
import 'package:meals_app/src/model/meals.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.changeState,
  });
  final Meal meal;
  final void Function() changeState;

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.meal.title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                widget.meal.isFavorite = !widget.meal.isFavorite;
                widget.changeState();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('${widget.meal.isFavorite ? "Added to" : "Removed from"} Favorite'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              });
            },
            icon: Icon(
              !widget.meal.isFavorite ? Icons.star_border : Icons.star,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FadeInImage(
              width: double.infinity,
              height: 300,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(widget.meal.imageUrl),
            ),
            const SizedBox(
              height: 14,
            ),
            const _FancyHeader(text: 'Ingredients'),
            for (int i = 0; i < widget.meal.ingredients.length; i++)
              _FancyText(idx: i + 1, text: widget.meal.ingredients[i]),
            const SizedBox(
              height: 10,
            ),
            const _FancyHeader(text: "Steps"),
            for (int i = 0; i < widget.meal.steps.length; i++)
              _FancyText(
                idx: i + 1,
                text: widget.meal.steps[i],
              ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _FancyText extends StatelessWidget {
  const _FancyText({required this.idx, required this.text});
  final int idx;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            idx.toString(),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
              maxLines: 5,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}

class _FancyHeader extends StatelessWidget {
  final String text;

  const _FancyHeader({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
