import 'package:assignment_car_on_sale/feature/home/domain/usecases/search_vehicle_by_vin_use_case.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:is_valid/is_valid.dart';

const _vinLength = 17;

class HomeCubit extends Cubit<HomeState> {
  final SearchVehicleByVinUseCase searchVehicleByVinUseCase;

  HomeCubit(
    this.searchVehicleByVinUseCase,
  ) : super(HomeInitialState());

  void searchVin(final String vin) async {
    emit(HomeLoadingState());
    if (!IsValid.validateVIN(vin: vin, vinLength: _vinLength)) {
      emit(HomeErrorState(
          'Pin isn\'t valid, please use pin like 1G1AZ123456789012'));
    } else {
      final result = await searchVehicleByVinUseCase.call(
        VehicleParam(vin),
      );
      result.fold(
        (failure) {
          emit(
            HomeErrorState(
              failure.message,
            ),
          );
        },
        (vehicle) {
          emit(
            HomeSuccessVinState(
              vehicle,
            ),
          );
        },
      );
    }
  }
}
