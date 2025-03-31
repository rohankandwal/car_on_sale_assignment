import 'package:equatable/equatable.dart';

sealed class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSearchVinState extends HomeState {
  final String vin;

  HomeSearchVinState(this.vin);

  @override
  List<Object?> get props => [
        vin,
      ];
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);

  @override
  List<Object?> get props => [
        message,
      ];
}
