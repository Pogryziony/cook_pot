import 'package:cook_pot/models/recipe.dart';
import 'package:cook_pot/modules/recipes/appetizers_bloc.dart';
import 'package:cook_pot/widgets/card/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'appetizers_bloc.dart';

class AppetizersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Appetizer menu'),
          backgroundColor: Colors.lightGreen,
        ),
        body: BlocBuilder<AppetizersBloc, AppetizersState>(
          builder: (BuildContext context, AppetizersState state) {
            if (state is AppetizersLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AppetizersLoadErrorState) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is AppetizersLoadedState) {
              return _appetizerList(state.appetizers);
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ));
  }

  Widget _appetizerList(List<Recipe> appetizers) {
    return ListView.builder(
        itemCount: appetizers.length,
        itemBuilder: (BuildContext context, int index) {
          return RecipeCard(
            recipeName: appetizers[index].name!.toString(),
            assetPath: appetizers[index].image!,
            preparationTime: 'Preparation time: ' +
                appetizers[index].preparationTime.toString(),
            callbackFunction: () => {},
          );
        });
  }
}
