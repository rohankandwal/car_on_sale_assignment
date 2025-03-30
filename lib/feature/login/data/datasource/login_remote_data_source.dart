import 'package:assignment_car_on_sale/core/network/network_request.dart';
import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';
import 'package:assignment_car_on_sale/feature/login/data/network/rest_client.dart';

/// Data source layer
sealed class LoginRemoteDataSource {
  Future<UserModel> login({
    required final String email,
    required final String password,
  });
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final RestClient _client;

  LoginRemoteDataSourceImpl(this._client);

  @override
  Future<UserModel> login({
    required final String email,
    required final String password,
  }) async {
    try {
      final networkRequest = NetworkRequest(
        endPoint: "login",
        requestBody: {
          "email": email,
          "password": password,
        },
      );

      return await _client.post(networkRequest);
    } catch (e) {
      rethrow;
    }
  }
}
