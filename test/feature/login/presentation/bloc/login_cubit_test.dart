import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/login/domain/usecases/login_use_case.dart';
import 'package:assignment_car_on_sale/feature/login/presentation/bloc/login_cubit.dart';
import 'package:assignment_car_on_sale/feature/login/presentation/bloc/login_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late final LoginUseCase loginUseCase;
  const email = 'r@r.com';
  const password = '123456';
  const serverError = 'ServerError';

  setUpAll(() {
    loginUseCase = MockLoginUseCase();
    registerFallbackValue(LoginParams(email: email, password: email));
  });

  LoginCubit getBloc() => LoginCubit(loginUseCase);

  group('LoginCubit tests', () {
    blocTest(
      'Login test with incorrect email',
      build: getBloc,
      act: (cubit) {
        cubit.loginNow(email: 'email@email', password: password);
      },
      verify: (cubit) {
        verifyNever(
          () => loginUseCase.call(
            any(),
          ),
        );
      },
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginErrorState>().having(
          (state) => state.message,
          'Checking error message',
          equals(
            'Incorrect Email format, please check',
          ),
        ),
      ],
    );

    blocTest(
      'Login test with password less than $passwordLength characters',
      build: getBloc,
      act: (cubit) {
        var password = '';
        for (var i = 1; i < passwordLength; i++) {
          password += '$i';
        }
        cubit.loginNow(email: email, password: password);
      },
      verify: (cubit) {
        verifyNever(
          () => loginUseCase.call(
            any(),
          ),
        );
      },
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginErrorState>().having(
          (state) => state.message,
          'Checking error message',
          equals(
            'Please enter password greater than ${passwordLength - 1} characters',
          ),
        ),
      ],
    );

    blocTest(
      'Login test with incorrect email and password less than $passwordLength characters',
      build: getBloc,
      act: (cubit) {
        var password = '';
        for (var i = 1; i < passwordLength; i++) {
          password += '$i';
        }
        cubit.loginNow(email: 'email', password: password);
      },
      verify: (cubit) {
        verifyNever(
          () => loginUseCase.call(
            any(),
          ),
        );
      },
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginErrorState>().having(
          (state) => state.message,
          'Checking error message',
          equals(
            'Please enter valid email address and password should be more '
            'than ${passwordLength - 1} characters',
          ),
        ),
      ],
    );

    blocTest(
      'Login failure test with correct email and password',
      build: getBloc,
      act: (cubit) {
        when(() => loginUseCase.call(any())).thenAnswer(
          (_) async => Left(
            ServerFailure(serverError),
          ),
        );
        cubit.loginNow(email: email, password: password);
      },
      verify: (cubit) {
        verify(
          () => loginUseCase.call(
            any(),
          ),
        ).called(1);
      },
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginErrorState>().having(
          (state) => state.message,
          'Checking if correct message is returned',
          equals(serverError),
        ),
      ],
    );

    blocTest(
      'Login success test with correct email and password',
      build: getBloc,
      act: (cubit) {
        when(() => loginUseCase.call(any()))
            .thenAnswer((_) async => Right(true));
        cubit.loginNow(email: email, password: password);
      },
      verify: (cubit) {
        verify(
          () => loginUseCase.call(
            any(),
          ),
        ).called(1);
      },
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginSuccessState>(),
      ],
    );
  });
}
