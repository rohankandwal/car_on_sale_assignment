import 'package:assignment_car_on_sale/core/base_failures/base_failures.dart';
import 'package:assignment_car_on_sale/feature/login/domain/repository/login_repository.dart';
import 'package:assignment_car_on_sale/feature/login/domain/usecases/login_use_case.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  const email = 'r@r.com';
  const password = '123456';
  const serverError = 'ServerError';

  late final LoginUseCase loginUseCase;
  late final LoginRepository repository;

  setUpAll(() {
    repository = MockLoginRepository();
    loginUseCase = LoginUseCase(repository);
  });

  group('LoginUseCase tests', () {
    test('LoginUseCase success', () async {
      when(
        () => repository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Right(true));

      final result = await loginUseCase.call(
        LoginParams(
          email: email,
          password: password,
        ),
      );

      verify(() => repository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).called(1);
      expect(result, isA<Right>());
    });

    test('LoginUseCase failure', () async {
      when(
        () => repository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(serverError),
        ),
      );

      final result = await loginUseCase.call(
        LoginParams(
          email: email,
          password: password,
        ),
      );

      verify(() => repository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).called(1);
      expect(
        result,
        isA<Left>().having(
          (state) => (state.left as ServerFailure).message,
          'Checking message',
          equals(serverError),
        ),
      );
    });
  });
}
