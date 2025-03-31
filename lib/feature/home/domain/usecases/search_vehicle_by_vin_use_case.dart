import 'package:assignment_car_on_sale/core/base_usecase/usecase.dart';
import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_search_entity.dart';
import 'package:either_dart/either.dart';

class SearchVehicleByVinUseCase
    extends UseCase<VehicleSearchEntity, VehicleParam> {
  @override
  Future<Either<BaseFailure, VehicleSearchEntity>> call(
    final VehicleParam param,
  ) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class VehicleParam {
  final String vin;

  VehicleParam(this.vin);
}
