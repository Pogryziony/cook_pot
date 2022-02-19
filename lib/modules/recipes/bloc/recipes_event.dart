part of 'recipes_bloc.dart';

abstract class RecipesEvent extends Equatable {
  const RecipesEvent();

  @override
  List<Object> get props => [];
}

class LoadRecipesEvent extends RecipesEvent {}

class AddRecipeEvent extends RecipesEvent {
  final Recipe recipe;

  AddRecipeEvent(this.recipe);

  @override
  List<Object> get props => [recipe];
}

class LoadFilteredRecipesEvent extends RecipesEvent {
  const LoadFilteredRecipesEvent(
      this.difficultyValues, this.portionsValues,this.minPrepTime,this.maxPrepTime, this.recipes);

  final Map<String, bool> difficultyValues;
  final Map<String, bool> portionsValues;
  final int minPrepTime;
  final int maxPrepTime;
  final List<Recipe> recipes;

  @override
  List<Object> get props => [difficultyValues, portionsValues, minPrepTime, maxPrepTime ,recipes];
}
