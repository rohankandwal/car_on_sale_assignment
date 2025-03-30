import 'package:assignment_car_on_sale/feature/login/data/mapper/user_model_mapper.dart';
import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModelMapper', () {
    const testName = 'Test User';
    const testToken = '12345';

    final userModel = UserModel(name: testName, token: testToken);
    final mapper = UserModelMapper();

    test('mapModelToEntity returns UserEntity with matching properties', () {
      final result = mapper.mapModelToEntity(userModel);

      expect(result.name, testName);
      expect(result.token, testToken);
    });

    test('mapModelToEntity returns new instance with different identity', () {
      final result = mapper.mapModelToEntity(userModel);

      expect(result, isNot(same(userModel))); // Verify new instance
    });
  });
}
