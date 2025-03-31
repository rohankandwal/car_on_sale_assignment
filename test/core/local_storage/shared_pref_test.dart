import 'package:assignment_car_on_sale/core/local_storage/shared_pref.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/mocks.dart';

void main() {
  late FlutterSecureStorage mockStorage;
  late SharedPrefImpl sharedPref;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    sharedPref = SharedPrefImpl(mockStorage);
  });

  group('getString()', () {
    const testKey = 'auth_token';
    const testValue = 'test_token_123';

    test('should return stored value when key exists', () async {
      when(() => mockStorage.read(key: testKey))
          .thenAnswer((_) async => testValue);

      final result = await sharedPref.getString(key: testKey);

      expect(result, testValue);
      verify(() => mockStorage.read(key: testKey)).called(1);
    });

    test('should return null when key does not exist', () async {
      when(() => mockStorage.read(key: testKey)).thenAnswer((_) async => null);

      final result = await sharedPref.getString(key: testKey);

      expect(result, isNull);
      verify(() => mockStorage.read(key: testKey)).called(1);
    });

    test('should propagate storage exceptions', () async {
      final exception = Exception('Storage error');
      when(() => mockStorage.read(key: testKey)).thenThrow(exception);

      expect(() => sharedPref.getString(key: testKey), throwsA(exception));
    });
  });

  group('saveString()', () {
    const testKey = 'user_settings';
    const testValue = 'dark_mode_enabled';

    test('should store value with correct key', () async {
      when(() => mockStorage.write(key: testKey, value: testValue))
          .thenAnswer((_) async {});

      await sharedPref.saveString(key: testKey, data: testValue);

      verify(() => mockStorage.write(key: testKey, value: testValue)).called(1);
    });

    test('should propagate storage exceptions', () async {
      final exception = Exception('Write error');
      when(() => mockStorage.write(key: testKey, value: testValue))
          .thenThrow(exception);

      expect(
        () => sharedPref.saveString(key: testKey, data: testValue),
        throwsA(exception),
      );
    });

    test('Clears all the keys', () async {
      when(
        () => mockStorage.deleteAll(),
      ).thenAnswer((_) async => {});

      await sharedPref.clearData();

      verify(() => mockStorage.deleteAll()).called(1);
    });
  });
}
