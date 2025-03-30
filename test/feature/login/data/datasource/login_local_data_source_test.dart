import 'dart:convert';

import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/feature/login/data/datasource/login_local_data_source.dart';
import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late MockSharedPref mockSharedPref;
  late LoginLocalDataSourceImpl dataSource;
  const userInfoKey = 'user_info';
  final testUser = UserModel(name: 'Test', token: 'token123');

  setUp(() {
    mockSharedPref = MockSharedPref();
    dataSource = LoginLocalDataSourceImpl(mockSharedPref);
  });

  group('getUserInformation', () {
    test('returns null when no user data exists', () async {
      when(
        () => mockSharedPref.getString(
          key: userInfoKey,
        ),
      ).thenAnswer((_) async => null);

      final result = await dataSource.getUserInformation();

      expect(result, isNull);
      verify(
        () => mockSharedPref.getString(
          key: userInfoKey,
        ),
      ).called(1);
    });

    test('returns UserModel when valid data exists', () async {
      final jsonData = jsonEncode(testUser.toJson());
      when(
        () => mockSharedPref.getString(
          key: userInfoKey,
        ),
      ).thenAnswer((_) async => jsonData);

      final result = await dataSource.getUserInformation();

      expect(result, isA<UserModel>());
      expect(result?.name, testUser.name);
      expect(result?.token, testUser.token);
    });

    test('throws ParsingException on invalid JSON format', () async {
      when(
        () => mockSharedPref.getString(
          key: userInfoKey,
        ),
      ).thenAnswer((_) async => '{invalid_json}');

      expect(() => dataSource.getUserInformation(),
          throwsA(isA<ParsingException>()));
    });

    test('throws CacheException on general storage errors', () async {
      when(
        () => mockSharedPref.getString(
          key: userInfoKey,
        ),
      ).thenThrow(Exception());

      expect(() => dataSource.getUserInformation(),
          throwsA(isA<CacheException>()));
    });
  });

  group('saveUserInformation', () {
    test('saves valid user data correctly', () async {
      final expectedJson = jsonEncode(testUser.toJson());
      when(
        () => mockSharedPref.saveString(
          key: userInfoKey,
          data: expectedJson,
        ),
      ).thenAnswer((_) async => {});

      await dataSource.saveUserInformation(testUser);

      verify(
        () => mockSharedPref.saveString(
          key: userInfoKey,
          data: expectedJson,
        ),
      ).called(1);
    });

    test('propagates storage exceptions', () async {
      final exception = Exception('Storage failed');
      when(
        () => mockSharedPref.saveString(
          key: any(named: 'key'),
          data: any(named: 'data'),
        ),
      ).thenThrow(exception);

      expect(
        () => dataSource.saveUserInformation(testUser),
        throwsA(exception),
      );
    });
  });
}
