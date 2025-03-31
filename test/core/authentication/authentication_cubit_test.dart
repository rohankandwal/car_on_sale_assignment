import 'package:assignment_car_on_sale/core/authentication/authentication_cubit.dart';
import 'package:assignment_car_on_sale/core/authentication/authentication_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/mocks.dart';

void main() {
  late MockSharedPref mockSharedPref;
  late AuthenticationCubit cubit;

  setUp(() {
    mockSharedPref = MockSharedPref();
    cubit = AuthenticationCubit(mockSharedPref);
  });

  tearDown(() => cubit.close());

  group('AuthenticationCubit', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [UserAuthorizedState] when user data exists',
      build: () => cubit,
      act: (cubit) => cubit.checkIfUserAuthenticated(),
      setUp: () {
        when(() => mockSharedPref.getString(key: any(named: 'key')))
            .thenAnswer((_) async => 'valid_user_data');
      },
      expect: () => [
        isA<UserAuthorizedState>(),
      ],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [UserNotAuthorizedState] when no user data exists',
      build: () => cubit,
      act: (cubit) => cubit.checkIfUserAuthenticated(),
      setUp: () {
        when(() => mockSharedPref.getString(key: any(named: 'key')))
            .thenAnswer((_) async => null);
      },
      expect: () => [
        isA<UserNotAuthorizedState>(),
      ],
    );
  });

  blocTest<AuthenticationCubit, AuthenticationState>(
    'emits [UserNotAuthorizedState] when user logs out',
    build: () => cubit,
    act: (cubit) => cubit.logout(),
    setUp: () {
      when(() => mockSharedPref.clearData()).thenAnswer((_) async => {});
    },
    expect: () => [
      isA<UserNotAuthorizedState>(),
    ],
  );
}
