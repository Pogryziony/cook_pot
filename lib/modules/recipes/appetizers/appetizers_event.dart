part of 'appetizers_bloc.dart';

abstract class AppetizersEvent extends Equatable {
  const AppetizersEvent();

  @override
  List<Object> get props => [];
}

class LoadAppetizersEvent extends AppetizersEvent{}