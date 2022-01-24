part of 'recipes_bloc.dart';

abstract class RecipesEvent extends Equatable {
  const RecipesEvent();

  @override
  List<Object> get props => [];
}

class LoadRecipesEvent extends RecipesEvent {}

class LoadFilteredRecipesEvent extends RecipesEvent {
  const LoadFilteredRecipesEvent(this.isEasy, this.appetizers);

  final bool isEasy;
  final List<Recipe> appetizers;

  @override
  List<Object> get props => [isEasy, appetizers];
}
