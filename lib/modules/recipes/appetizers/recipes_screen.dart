import 'package:cook_pot/models/recipe.dart';
import 'package:cook_pot/modules/recipes/appetizers/appetizer_create_form.dart';
import 'package:cook_pot/modules/recipes/appetizers/appetizer_detail_screen.dart';
import 'package:cook_pot/modules/recipes/bloc/recipes_bloc.dart';
import 'package:cook_pot/widgets/card/recipe_card.dart';
import 'package:cook_pot/widgets/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesScreen extends StatefulWidget {

  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {

  @override
  void initState() {
    String category = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appetizer menu'),
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Open search module',
            onPressed: () {
              // TODO handle the press
            },
          ),
          IconButton(
            icon: const Icon(Icons.dehaze_outlined),
            tooltip: 'Open filter module',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FilterList();
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
            return _recipesList(state.recipes);
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AppetizerCreateForm();
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _recipesList(List<Recipe> appetizers) {
    return ListView.builder(
        itemCount: appetizers.length,
        itemBuilder: (BuildContext context, int index) {
          return RecipeCard(
            recipeName: appetizers[index].name!,
            assetPath: appetizers[index].image!,
            preparationTime: appetizers[index].preparationTime.toString(),
            difficulty: appetizers[index].difficulty!,
            portions: appetizers[index].portions!,
            callbackFunction: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppetizerDetailScreen(
                    index: index,
                    name: appetizers[index].name!.toString(),
                    image: appetizers[index].image!,
                    preparationTime: appetizers[index].preparationTime!.toString(),
                    difficulty: appetizers[index].difficulty,
                    ingredients: appetizers[index].ingredients,
                    preparationSteps: appetizers[index].preparationSteps,
                    portions: appetizers[index].portions,
                  ),
                ),
              ),
            },
          );
        });
  }
}
