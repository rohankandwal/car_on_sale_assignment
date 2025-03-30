import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/login/data/datasource/login_remote_data_source.dart';
import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';
import 'package:assignment_car_on_sale/feature/login/data/repository/login_repository_impl.dart';
import 'package:assignment_car_on_sale/feature/login/domain/repository/login_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  const userModel = UserModel(name: 'name', token: 'token');
  const email = 'r@r.com';
  const password = '123456';
  const errorMessage = 'errorMessage';

  late final LoginRemoteDataSource dataSource;
  late final LoginRepository loginRepository;

  setUpAll(() {
    dataSource = MockLoginRemoteDataSource();
    loginRepository = LoginRepositoryImpl(dataSource);
  });

  group('LoginRepository tests', () {
    test('login success', () async {
      when(
        () => dataSource.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => userModel,
      );

      final result = await loginRepository.login(
        email: email,
        password: password,
      );

      verify(
        () => dataSource.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).called(1);

      expect(
        result,
        isA<Right>().having(
          (state) => state.right as bool,
          'True is returned',
          equals(true),
        ),
      );
    });

    test('login failure', () async {
      when(
        () => dataSource.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(NetworkException(errorMessage));

      final result = await loginRepository.login(
        email: email,
        password: password,
      );

      verify(
        () => dataSource.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).called(1);

      expect(
        result,
        isA<Left>().having(
          (state) => (state.left as BaseFailure).message,
          'Checking failure message',
          equals(errorMessage),
        ),
      );
    });
  });
}
