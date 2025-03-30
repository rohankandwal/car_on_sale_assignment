import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:assignment_car_on_sale/core/config/env_constants.dart';
import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/network/network_request.dart';
import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';
import 'package:http/http.dart' as auth_handler;

abstract class RestClient {
  /// 'POST' request
  Future<UserModel> post(
    final NetworkRequest request,
  );
}

class RestClientImpl extends RestClient {
  final auth_handler.BaseClient authenticationHandler;

  RestClientImpl(this.authenticationHandler);

  @override
  Future<UserModel> post(
    final NetworkRequest request,
  ) async {
    try {
      final endpoint = EnvConstants.environment.baseUrl;
      final response = await authenticationHandler.post(
        Uri.parse('$endpoint/${request.endPoint}'),
        body: request.requestBody,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final name = data['name'];
        final token = data['token'];
        return UserModel(
          name: name,
          token: token,
        );
      } else if (response.statusCode == 401) {
        throw AuthenticationException(_getErrorMessage(response.body));
      } else {
        throw ServerException(
            'Unknown error occurred, please try again later.');
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
