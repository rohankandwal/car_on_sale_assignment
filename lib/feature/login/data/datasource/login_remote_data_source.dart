import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';

/// Data source layer
sealed class LoginRemoteDataSource {
  Future<UserModel> login({
    required final String email,
    required final String password,
  });
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  @override
  Future<UserModel> login({
    required final String email,
    required final String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
