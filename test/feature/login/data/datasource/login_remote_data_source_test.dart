import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/network/network_request.dart';
import 'package:assignment_car_on_sale/feature/login/data/datasource/login_remote_data_source.dart';
import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';
import 'package:assignment_car_on_sale/feature/login/data/network/rest_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  const email = 'r@r.com';
  const password = '123456';
  const serverError = 'ServerError';
  const userModel = UserModel(name: 'name', token: 'token');

  late final RestClient restClient;
  late final LoginRemoteDataSource dataSource;

  setUpAll(() {
    restClient = MockRestClient();
    dataSource = LoginRemoteDataSourceImpl(restClient);
    registerFallbackValue(NetworkRequest(endPoint: 'url'));
  });

  group('LoginRemoteDataSource tests', () {
    test('Login Success', () async {
      when(
        () => restClient.post(
          any(),
        ),
      ).thenAnswer(
        (_) async => userModel,
      );

      final result = await dataSource.login(
        email: email,
        password: password,
      );

      verify(() => restClient.post(any())).called(1);
      expect(result, userModel);
    });

    test('Login failure', () async {
      when(
        () => restClient.post(
          any(),
        ),
      ).thenThrow(
        AuthenticationException(serverError),
      );

      expect(
        () async => await dataSource.login(
          email: email,
          password: password,
        ),
        throwsA(
          isA<BaseException>().having(
            (error) => error.message,
            'Checking error message',
            equals(
              serverError,
            ),
          ),
        ),
      );
    });
  });
}
