import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_search_entity.dart';
import 'package:either_dart/either.dart';

/// Class used to get vehicle information from server
abstract class HomeRepository {
  /// Get vehicle information by VIN
  Future<Either<BaseFailure, VehicleSearchEntity>> searchVehicleByVin(
    final String vin,
  );
}
