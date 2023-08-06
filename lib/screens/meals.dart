import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:taste_tales/screens/meal_details.dart';
import 'package:taste_tales/widgets/meal_item.dart';

import '../models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    // Navigator.push(context, route);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (builderContext) => MealDetailsScreen(
        meal: meal,
      ),
    ));
  }

  Future<void> _handleRefresh() async {
    return await Future.delayed(
      Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget content = width < 550
        ? LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) => MealItem(
                meal: meals[index],
                onMealSelect: (meal) {
                  _selectMeal(context, meal);
                },
              ),
            ),
          )
        : LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            height: 100,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: GridView(
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
            ),
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
