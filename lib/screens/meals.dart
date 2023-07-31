import 'package:flutter/material.dart';
import 'package:taste_tales/screens/meal_details.dart';
import 'package:taste_tales/widgets/meal_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.onToggleFavorite});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  void _selectMeal(BuildContext context, Meal meal) {
    // Navigator.push(context, route);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (builderContext) => MealDetailsScreen(
        meal: meal,
        onToggleFavorite: onToggleFavorite,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget content = width < 550
        ? ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) => MealItem(
              meal: meals[index],
              onMealSelect: (meal) {
                _selectMeal(context, meal);
              },
            ),
          )
        : GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2,
              mainAxisSpacing: 10,
            ),
            children: [
              for (final meal in meals)
                ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: 1,
                  itemBuilder: (context, index) => MealItem(
                    meal: meal,
                    onMealSelect: (meal) {
                      _selectMeal(context, meal);
                    },
                  ),
                ),
            ],
          );
    if (meals.isEmpty) {
      content = Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            'Nothing hare!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          )
        ]),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
