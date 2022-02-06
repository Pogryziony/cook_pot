part of 'recipes_bloc.dart';

abstract class RecipesState extends Equatable {
  const RecipesState();

  @override
  List<Object> get props => [];
}

class RecipesInitial extends RecipesState {

}

class RecipesLoadedState extends RecipesState{
  const RecipesLoadedState(this.recipes);

  final List<Recipe> recipes;

  @override
  List<Object> get props => [recipes];
}

class RecipesLoadErrorState extends RecipesState{
  const RecipesLoadErrorState(this.error);

  final String error;
}

class RecipesLoadingState extends RecipesState{
  const RecipesLoadingState();

}

class AddRecipeState extends RecipesState{
  const AddRecipeState();

}
