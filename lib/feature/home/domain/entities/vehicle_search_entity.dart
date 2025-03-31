import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_information_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_similar_entity.dart';
import 'package:equatable/equatable.dart';

class VehicleSearchEntity extends Equatable {
  final VehicleInformationEntity vehicleInformation;
  final List<VehicleSimilarEntity> similarVehicles;

  const VehicleSearchEntity(
    this.vehicleInformation,
    this.similarVehicles,
  );

  @override
  List<Object?> get props => [
        vehicleInformation,
        similarVehicles,
      ];
}
