import 'dart:convert';

import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/local_storage/shared_pref.dart';
import 'package:assignment_car_on_sale/core/utils/string_constants.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_search_model.dart';

sealed class HomeLocalDataSource {
  Future<VehicleSearchModel?> getVehicleInformationByVin(
    final String vin,
  );

  Future<void> saveVehicleInformation(
    final VehicleSearchModel vehicleInformation,
    final String vin,
  );

  Future<String?> getVehicleInformationSavedTimeStamp(
    final String vin,
  );
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  final SharedPref sharedPref;

  HomeLocalDataSourceImpl(this.sharedPref);

  @override
  Future<VehicleSearchModel?> getVehicleInformationByVin(
    final String vin,
  ) async {
    try {
      final value = await sharedPref.getString(key: vin);
      return value == null
          ? null
          : VehicleSearchModel.fromJson(jsonDecode(value));
    } on FormatException {
      throw ParsingException(
        'Error getting vehicle information from cache',
      );
    }
  }

  @override
  Future<void> saveVehicleInformation(
    final VehicleSearchModel vehicleInformation,
    final String vin,
  ) async {
    try {
      await sharedPref.saveString(
        key: vin,
        data: jsonEncode(vehicleInformation.toJson()),
      );
      await sharedPref.saveString(
        key: '$vin${StringConstants.timeStamp}',
        data: DateTime.now().toString(),
      );
    } on FormatException {
      throw ParsingException(
        'Error getting vehicle information from cache',
      );
    }
  }

  @override
  Future<String?> getVehicleInformationSavedTimeStamp(final String vin) {
    return sharedPref.getString(key: '$vin${StringConstants.timeStamp}');
  }
}
