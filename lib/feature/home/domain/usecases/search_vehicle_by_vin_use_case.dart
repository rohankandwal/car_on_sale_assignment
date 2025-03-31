import 'package:assignment_car_on_sale/core/base_usecase/usecase.dart';
import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_search_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/repository/home_repository.dart';
import 'package:either_dart/either.dart';

class SearchVehicleByVinUseCase
    extends UseCase<VehicleSearchEntity, VehicleParam> {
  final HomeRepository repository;

  SearchVehicleByVinUseCase(this.repository);

  @override
  Future<Either<BaseFailure, VehicleSearchEntity>> call(
    final VehicleParam param,
  ) {
    return repository.searchVehicleByVin(param.vin);
  }
}

class VehicleParam {
  final String vin;

  VehicleParam(this.vin);
}
