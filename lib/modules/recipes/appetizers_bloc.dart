import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cook_pot/models/recipe.dart';
import 'package:cook_pot/utils/services/firestore_service.dart';
import 'package:equatable/equatable.dart';

part 'appetizers_event.dart';
part 'appetizers_state.dart';

class AppetizersBloc extends Bloc<AppetizersEvent, AppetizersState> {
  AppetizersBloc() : _firestoreService = FirestoreService(), super(AppetizersInitial());
  final FirestoreService _firestoreService;

  @override
  Stream<AppetizersState> mapEventToState(
      AppetizersEvent event,
      ) async* {
    if (event is LoadAppetizersEvent) {
      yield* _mapLoadAppetizersEventToState();
    }
  }

  Stream<AppetizersState> _mapLoadAppetizersEventToState() async* {
    yield const AppetizersLoadingState();
    try{
      final List<Recipe> appetizers = await _firestoreService.getRecipes();
      yield AppetizersLoadedState(appetizers);
    }catch(e){
      yield AppetizersLoadErrorState(e.toString());
    }
  }
}
