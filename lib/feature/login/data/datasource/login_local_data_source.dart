import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';

sealed class LoginLocalDataSource {
  Future<UserModel?> getUserInformation();
  Future<bool> saveUserInformation();
}

class LoginLocalDataSourceImpl extends LoginLocalDataSource {
  @override
  Future<UserModel?> getUserInformation() {
    // TODO: implement getUserInformation
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUserInformation() {
    // TODO: implement saveUserInformation
    throw UnimplementedError();
  }
}
