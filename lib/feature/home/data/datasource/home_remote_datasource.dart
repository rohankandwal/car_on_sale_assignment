import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_search_model.dart';

sealed class HomeRemoteDataSource {
  Future<VehicleSearchModel> searchVehicleByVin(final String vin);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  @override
  Future<VehicleSearchModel> searchVehicleByVin(final String vin) {
    // TODO: implement searchVehicleByVin
    throw UnimplementedError();
  }
}
