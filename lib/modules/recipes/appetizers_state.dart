part of 'appetizers_bloc.dart';

abstract class AppetizersState extends Equatable {
  const AppetizersState();

  @override
  List<Object> get props => [];
}

class AppetizersInitial extends AppetizersState {

}

class AppetizersLoadedState extends AppetizersState{
  const AppetizersLoadedState(this.appetizers);

  final List<Recipe> appetizers;
}

class AppetizersLoadErrorState extends AppetizersState{
  const AppetizersLoadErrorState(this.error);

  final String error;
}

class AppetizersLoadingState extends AppetizersState{
  const AppetizersLoadingState();

}
