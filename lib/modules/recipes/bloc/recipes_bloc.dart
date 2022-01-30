import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cook_pot/models/recipe.dart';
import 'package:cook_pot/utils/services/firestore_service.dart';
import 'package:equatable/equatable.dart';

part 'recipes_event.dart';

part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc()
      : _firestoreService = FirestoreService(),
        super(RecipesInitial());
  final FirestoreService _firestoreService;

  late String category;
  late String currentCategory;
  List<Recipe> recipesList = [];

  @override
  Stream<RecipesState> mapEventToState(
    RecipesEvent event,
  ) async* {
    if (event is LoadRecipesEvent) {
      yield* _mapLoadRecipesEventToState();
    } else if (event is LoadFilteredRecipesEvent) {
      yield* _mapLoadFilteredRecipesEventToState(event);
    } else if (event is AddRecipeEvent){
      yield* _mapAddRecipeToState(event);
    }
  }

  Stream<RecipesState> _mapLoadRecipesEventToState() async* {
    yield const RecipesLoadingState();
    try {
      final List<Recipe> recipes =
          await _firestoreService.getRecipesFromCategory('$category');
      recipesList = recipes;
      yield RecipesLoadedState(recipes);
    } catch (e) {
      yield RecipesLoadErrorState(e.toString());
    }
  }

  Stream<RecipesState> _mapLoadFilteredRecipesEventToState(
      LoadFilteredRecipesEvent event) async* {
    if (event.isEasy) {
      recipesList = event.appetizers
          .where((element) => element.difficulty == 'Easy')
          .toList();
    }
    yield RecipesLoadedState(recipesList);
  }

  Stream<RecipesState> _mapAddRecipeToState(
      AddRecipeEvent event) async* {
    _firestoreService.addNewRecipe(event.recipe);
  }


// yield const RecipesLoadingState();
// try{
//   final List<Recipe> recipes = await _firestoreService.getRecipesFromCategoryWithFilters('$currentCategory');
//   yield RecipesLoadedState(recipes);
// }catch(e){
//   yield RecipesLoadErrorState(e.toString());
// }
}
