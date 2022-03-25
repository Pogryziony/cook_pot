import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_pot/models/recipe.dart';
import 'package:cook_pot/utils/services/firestore_service.dart';
import 'package:equatable/equatable.dart';

part 'recipes_event.dart';

part 'recipes_state.dart';

final FirebaseFirestore _databaseInstance = FirebaseFirestore.instance;

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
    } else if (event is AddRecipeEvent) {
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
    if (getKeysWhenTrueFromMap(event.difficultyValues).isNotEmpty) {
      recipesList = recipesList
          .where((element) => getKeysWhenTrueFromMap(event.difficultyValues)
              .toString()
              .contains(element.difficulty.toString()))
          .toList();
    }
    if (getKeysWhenTrueFromMap(event.portionsValues).isNotEmpty) {
      recipesList = recipesList
          .where((element) => getKeysWhenTrueFromMap(event.portionsValues)
              .toString()
              .contains(element.portions.toString()))
          .toList();
    }
    if (event.minPrepTime >= 0 && event.maxPrepTime <= 360) {
      recipesList = recipesList
          .where((element) =>
              element.preparationTime >= event.minPrepTime &&
              element.preparationTime <= event.maxPrepTime)
          .toList();
    }

    yield RecipesLoadedState(recipesList);
  }

  Stream<RecipesState> _mapAddRecipeToState(AddRecipeEvent event) async* {
    _firestoreService.addNewRecipe(event.recipe);
  }

  getKeysWhenTrueFromMap(Map<String, bool> map) {
    List<String> keys = [];
    map.forEach((key, value) {
      if (value.toString() == 'true') {
        keys.add(key);
      }
    });
    return keys;
  }
}
