import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:assignment_car_on_sale/core/config/env_constants.dart';
import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/network/network_request.dart';
import 'package:assignment_car_on_sale/environments.dart';
import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';
import 'package:assignment_car_on_sale/feature/login/data/network/rest_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as auth_handler;
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  const token = 'token';
  const name = 'Rohan Kandwal';
  const jsonBody200TokenResponse = '''{"token":"$token", "name": "$name"}''';
  const userModel = UserModel(name: name, token: token);

  late final auth_handler.BaseClient authClient;
  late final RestClient restClient;

  setUpAll(() {
    EnvConstants.setEnvironment(Environment.dev);
    authClient = MockHttpHandler();
    restClient = RestClientImpl(authClient);
    registerFallbackValue(Uri.parse('uri'));
  });

  group('RestClient tests', () {
    test('Login success', () async {
      when(
        () => authClient.post(
          any(),
        ),
      ).thenAnswer(
        (_) async => auth_handler.Response(jsonBody200TokenResponse, 200),
      );

      final result = await restClient.post(NetworkRequest(endPoint: '/login'));

      verify(
        () => authClient.post(
          any(),
        ),
      ).called(1);
      expect(result, userModel);
    });

    test('Login parseException', () async {
      when(
        () => authClient.post(
          any(),
        ),
      ).thenAnswer(
        (_) async => auth_handler.Response(
          'jsonBody200TokenResponse',
          200,
        ),
      );

      expect(
        () => restClient.post(NetworkRequest(endPoint: '/login')),
        throwsA(
          isA<ParsingException>(),
        ),
      );
    });

    test('Login AuthenticationException', () async {
      when(
        () => authClient.post(
          any(),
        ),
      ).thenAnswer(
        (_) async => auth_handler.Response(
          jsonEncode({'error': 'Incorrect credentials'}),
          401,
        ),
      );

      expect(
        () => restClient.post(NetworkRequest(endPoint: '/login')),
        throwsA(
          isA<AuthenticationException>().having(
            (state) => state.message,
            'Checking message',
            equals('Incorrect credentials'),
          ),
        ),
      );
    });

    test('Login SocketException', () async {
      when(
        () => authClient.post(
          any(),
        ),
      ).thenThrow(
        SocketException(''),
      );

      expect(
        () => restClient.post(NetworkRequest(endPoint: '/login')),
        throwsA(
          isA<NetworkException>().having(
            (state) => state.message,
            'Checking message',
            equals('No Internet connection, please check your network.'),
          ),
        ),
      );
    });

    test('Login TimeoutException', () async {
      when(
        () => authClient.post(
          any(),
        ),
      ).thenThrow(
        TimeoutException(''),
      );

      expect(
        () => restClient.post(NetworkRequest(endPoint: '/login')),
        throwsA(
          isA<NetworkException>().having(
            (state) => state.message,
            'Checking message',
            equals('Slow internet connection, please try again later.'),
          ),
        ),
      );
    });

    test('Login NetworkException', () async {
      when(
        () => authClient.post(
          any(),
        ),
      ).thenThrow(
        NetworkException(''),
      );

      expect(
        () => restClient.post(NetworkRequest(endPoint: '/login')),
        throwsA(
          isA<NetworkException>().having(
            (state) => state.message,
            'Checking message',
            equals('Unknown error occurred, please try again later.'),
          ),
        ),
      );
    });
  });
}
