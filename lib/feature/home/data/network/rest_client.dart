import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:assignment_car_on_sale/core/config/env_constants.dart';
import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/network/network_request.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_information_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_search_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_similarity_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/network/mock_http_handler.dart';

sealed class RestClient {
  /// 'POST' request
  Future<VehicleSearchModel> post(
    final NetworkRequest request,
  );
}

class RestClientImpl extends RestClient {
  @override
  Future<VehicleSearchModel> post(final NetworkRequest request) async {
    try {
      final endpoint = EnvConstants.environment.baseUrl;
      final response = await CosChallenge.httpClient.post(
        Uri.parse('$endpoint/${request.endPoint}'),
        body: request.requestBody,
        headers: request.headers,
      );

      final jsonMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return VehicleSearchModel(
            informationModel: VehicleInformationModel.fromJson(jsonMap));
      } else if (response.statusCode == 300) {
        return VehicleSearchModel(
            similarityModels: (jsonMap as List)
                .map((e) => VehicleSimilarityModel.fromJson(e))
                .toList());
      } else if (response.statusCode == 400) {
        // Parse error message and return an exception or return an error object
        throw NetworkException(_getErrorMessage(response.body));
      } else {
        throw ServerException(
            'An unknown error occurred, please try again shortly.');
      }
    } on FormatException {
      throw ParsingException(
          'Missing some information from server, please try again later');
    } on SocketException {
      throw NetworkException(
          'No Internet connection, please check your network.');
    } on TimeoutException {
      throw NetworkException(
          'Slow internet connection, please try again later.');
    } on AuthenticationException {
      rethrow;
    } catch (e) {
      throw NetworkException('Unknown error occurred, please try again later.');
    }
  }

  String _getErrorMessage(final String responseBody) {
    return jsonDecode(responseBody)['error'];
  }
}
