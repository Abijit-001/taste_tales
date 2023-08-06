import 'package:flutter/material.dart';
import 'package:taste_tales/data/dummy_data.dart';
import 'package:taste_tales/models/category.dart';
import 'package:taste_tales/screens/meals.dart';

import '../models/meal.dart';
import '../widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    // Navigator.push(context, route);
    final filteredMeals = widget.availableMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (builderContext) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: _animationController,
        child: width < 600
            ? GridView(
                padding: EdgeInsets.all(24.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                children: [
                  for (final category in availableCategories)
                    CategoryGridItem(
                      category: category,
                      onSelectCategory: () =>
                          _selectCategory(context, category),
                    ),
                ],
              )
            : GridView(
                padding: EdgeInsets.all(24.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                children: [
                  for (final category in availableCategories)
                    CategoryGridItem(
                      category: category,
                      onSelectCategory: () =>
                          _selectCategory(context, category),
                    ),
                ],
              ),

        /// Padding Animated..........................................................
        /*builder: (context, child) => Padding(
          padding: EdgeInsets.only(
            top: 100 - _animationController.value * 100,
          ),
          child: child),*/

        /// Slide Transition with Curved Animation.......................................
        builder: (context, child) => SlideTransition(
              position:(Tween(
                begin: Offset(0, 0.4),
                end: Offset(0, 0),
              )).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
              child: child,
            ));
  }
}
