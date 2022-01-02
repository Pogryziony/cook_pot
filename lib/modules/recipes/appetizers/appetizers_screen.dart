import 'package:cook_pot/models/recipe.dart';
import 'package:cook_pot/modules/recipes/appetizers_bloc.dart';
import 'package:cook_pot/widgets/card/recipe_card.dart';
import 'package:cook_pot/widgets/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appetizers_bloc.dart';

class AppetizersScreen extends StatefulWidget {
  @override
  _AppetizersScreenState createState() => _AppetizersScreenState();
}

class _AppetizersScreenState extends State<AppetizersScreen> {
  final _formKey = GlobalKey<FormState>();

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
                // handle the press
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
