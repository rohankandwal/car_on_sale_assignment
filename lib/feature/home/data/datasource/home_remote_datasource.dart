import 'dart:convert';

import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/local_storage/shared_pref.dart';
import 'package:assignment_car_on_sale/core/network/network_request.dart';
import 'package:assignment_car_on_sale/core/utils/string_constants.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_search_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/network/rest_client.dart';
import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';

sealed class HomeRemoteDataSource {
  Future<VehicleSearchModel> searchVehicleByVin(final String vin);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final RestClient _client;
  final SharedPref _sharedPref;

  HomeRemoteDataSourceImpl(
    this._client,
    this._sharedPref,
  );

  @override
  Future<VehicleSearchModel> searchVehicleByVin(final String vin) async {
    try {
      final userInfoData =
          await _sharedPref.getString(key: StringConstants.userInfoKey);
      if (userInfoData == null) {
        throw AuthenticationException(
          'User information not found, please login again.',
        );
      }
      final userModel = UserModel.fromJson(jsonDecode(userInfoData));
      final networkRequest =
          NetworkRequest(endPoint: "searchVehicle", requestBody: {
        "vin": vin,
      }, headers: {
        'auth': userModel.token,
      });

      final vehicleInformation = await _client.post(networkRequest);
      return vehicleInformation;
    } catch (e) {
      rethrow;
    }
  }
}
