import 'package:assignment_car_on_sale/feature/login/data/entities/user_entity.dart';
import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';

/// Converts model to entity
class UserModelMapper {
  UserEntity mapModelToEntity(final UserModel userModel) {
    return UserEntity(name: userModel.name, token: userModel.token);
  }
}
