import 'package:cook_pot/models/recipe.dart';
import 'package:cook_pot/modules/recipes/appetizers/recipe_detail_screen.dart';
import 'package:cook_pot/modules/recipes/bloc/recipes_bloc.dart';
import 'package:cook_pot/widgets/card/recipe_card.dart';
import 'package:cook_pot/widgets/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RecipesScreen extends StatefulWidget {
  static var routeName = '/recipeScreen';

  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late List<Recipe> recipes;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getMenuName(),
        backgroundColor: Colors.lightGreen,
        leading: IconButton(
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil('/mainMenu', (_) => false),
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            icon: const Icon(MdiIcons.filter),
            tooltip: 'Open filter module',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FilterList(
                      onFiltered: (
                        Map<String, bool> difficultyValues,
                        Map<String, bool> portionValues,
                        int minPrepTime,
                        int maxPrepTime,
                      ) =>
                          {
                        BlocProvider.of<RecipesBloc>(context).add(
                            LoadFilteredRecipesEvent(
                                difficultyValues,
                                portionValues,
                                minPrepTime,
                                maxPrepTime,
                                recipes))
                      },
                    );
                  });
            },
          ),
        ],
      ),
      body: BlocBuilder<RecipesBloc, RecipesState>(
        builder: (BuildContext context, RecipesState state) {
          if (state is RecipesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RecipesLoadErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is RecipesLoadedState) {
            recipes = state.recipes;
            return _recipesList(recipes);
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => redirectToCreateForm(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _recipesList(List<Recipe> recipe) {
    return ListView.builder(
        itemCount: recipe.length,
        itemBuilder: (BuildContext context, int index) {
          return RecipeCard(
            recipeName: recipe[index].name,
            assetPath: recipe[index].image,
            preparationTime: recipe[index].preparationTime.toStringAsFixed(0),
            difficulty: recipe[index].difficulty,
            portions: recipe[index].portions,
            callbackFunction: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailScreen(
                    index: index,
                    name: recipe[index].name.toString(),
                    image: recipe[index].image,
                    preparationTime: recipe[index].preparationTime.toStringAsFixed(0),
                    difficulty: recipe[index].difficulty,
                    ingredients: recipe[index].ingredients,
                    preparationSteps: recipe[index].preparationSteps,
                    portions: recipe[index].portions,
                  ),
                ),
              ),
            },
          );
        });
  }

  Widget getMenuName() {
    switch (BlocProvider.of<RecipesBloc>(context).category) {
      case 'appetizer':
        return Text('Appetizer menu');
      case 'main_dish':
        return Text('Main dish menu');
      case 'drink':
        return Text('Drink menu');
      case 'dessert':
        return Text('Dessert menu');
      default:
        return ErrorWidget(Text('Unable to get menu name'));
    }
  }

  void redirectToCreateForm() {
    SchedulerBinding.instance?.addPostFrameCallback((_) => {
          Navigator.pushReplacementNamed(context, '/recipeCreateForm'),
        });
  }
}
