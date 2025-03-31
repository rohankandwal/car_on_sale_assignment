import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_search_entity.dart';
import 'package:either_dart/either.dart';

abstract class HomeRepository {
  Future<Either<BaseFailure, VehicleSearchEntity>> searchVehicleByVin(
    final String vin,
  );
}
