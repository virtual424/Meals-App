import 'package:flutter/material.dart';
import 'package:mealsapp/models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'Category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var loadedInitdata = false;

  @override
  void didChangeDependencies() {
    if (!loadedInitdata) {
      final routeArguments =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArguments['title'];
      final categoryID = routeArguments['id'];
      displayedMeals = widget.availableMeals.where(
        // where function returns a new iterable which we then convert into list based on the condition we provide int the function it accepsts. in this function we return true if we want to include a item in the new list else false.
        (meal) {
          return meal.categories.contains(categoryID);
        },
      ).toList();
      loadedInitdata = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            duration: displayedMeals[index].duration,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
