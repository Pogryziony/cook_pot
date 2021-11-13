import 'package:cook_pot/models/recipe.dart';
import 'package:cook_pot/modules/recipes/appetizers_bloc.dart';
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
    );
  }

  Widget _appetizerList(List<Recipe> appetizers) {
    return ListView.builder(
        itemCount: appetizers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(appetizers[index].name!),
            subtitle: Text(appetizers[index].preparationTime.toString()),
          );
        });
  }
}
