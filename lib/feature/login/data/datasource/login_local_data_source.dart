import 'dart:convert';

import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/local_storage/shared_pref.dart';
import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';

sealed class LoginLocalDataSource {
  Future<UserModel?> getUserInformation();

  Future<void> saveUserInformation(final UserModel userModel);
}

class LoginLocalDataSourceImpl extends LoginLocalDataSource {
  final userInfoKey = 'user_info';

  final SharedPrefImpl sharedPrefImpl;

  LoginLocalDataSourceImpl(this.sharedPrefImpl);

  @override
  Future<UserModel?> getUserInformation() async {
    try {
      final data = await sharedPrefImpl.getString(key: userInfoKey);
      if (data == null) {
        return null;
      }
      return UserModel.fromJson(jsonDecode(data));
    } on FormatException {
      throw ParsingException('Unable to fetch user information');
    } catch (e) {
      throw CacheException(
          'Some issue occurred while reading user information');
    }
  }

  @override
  Future<void> saveUserInformation(final UserModel userModel) {
    return sharedPrefImpl.saveString(
        key: userInfoKey, data: jsonEncode(userModel));
  }
}
