import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_search_entity.dart';
import 'package:equatable/equatable.dart';

sealed class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessVinState extends HomeState {
  final VehicleSearchEntity vehicleSearch;

  HomeSuccessVinState(this.vehicleSearch);

  @override
  List<Object?> get props => [
        vehicleSearch,
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
