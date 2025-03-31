import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:assignment_car_on_sale/core/config/env_constants.dart';
import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/network/network_request.dart';
import 'package:assignment_car_on_sale/core/utils/string_constants.dart';
import 'package:assignment_car_on_sale/environments.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_similarity_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/network/rest_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late MockHttpClient mockClient;
  late RestClientImpl restClient;
  final testVin = 'testVin';
  final testToken = 'test_token';
  final networkRequest = NetworkRequest(
      endPoint: StringConstants.endPointSearchVehicle,
      requestBody: {
        StringConstants.paramVin: testVin,
      },
      headers: {
        StringConstants.headerAuth: testToken,
      });

  const jsonVehicleInformation = '''
 {
      "id": 52972,
      "feedback": "Please modify the price.",
      "valuatedAt": "2023-01-05T14:08:40.456Z",
      "requestedAt": "2023-01-05T14:08:40.456Z",
      "createdAt": "2023-01-05T14:08:40.456Z",
      "updatedAt": "2023-01-05T14:08:42.153Z",
      "make": "Toyota",
      "model": "GT 86 Basis",
      "externalId": "DE003-018601450020008",
      "_fk_sellerUser": "25475e37-6973-483b-9b15-cfee721fc29f",
      "price": 327,
      "positiveCustomerFeedback": false,
      "_fk_uuid_auction": "3e255ad2-36d4-4048-a962-5e84e27bfa6e",
      "inspectorRequestedAt": "2023-01-05T14:08:40.456Z",
      "origin": "AUCTION",
      "estimationRequestId": "3a295387d07f"
    }''';

  const jsonVehicleOptions = '''[
     {
        "make": "Toyota",
        "model": "GT 86 Basis",
        "containerName": "DE - Cp2 2.0 EU5, 2012 - 2015",
        "similarity": 53,
        "externalId": "DE001-018601450020001"
    },
    {
        "make": "Toyota",
        "model": "GT 86 Basis",
        "containerName": "DE - Cp2 2.0 EU6, (EURO 6), 2015 - 2017",
        "similarity": 50,
        "externalId": "DE002-018601450020001"
    },
    {
        "make": "Toyota",
        "model": "GT 86 Basis",
        "containerName": "DE - Cp2 2.0 EU6, Basis, 2017 - 2020",
        "similarity": 0,
        "externalId": "DE003-018601450020001"
    }
]''';

  const json400Error = '''{
  "msgKey": "maintenance",
  "params": { "delaySeconds": "3" },
  "message": "Please try again in 3 seconds"
  }''';

  setUpAll(() {
    EnvConstants.setEnvironment(Environment.dev);
    mockClient = MockHttpClient();
    restClient = RestClientImpl(mockClient); // Inject mock client
    registerFallbackValue(Uri());
    registerFallbackValue(<String, String>{});
  });

  group('Home Client tests', () {
    test('returns VehicleSearchModel on 200 status', () async {
      final mockResponse = Response(jsonVehicleInformation, 200);

      when(() => mockClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => mockResponse);

      final result = await restClient.post(networkRequest);

      expect(result.informationModel?.model, 'GT 86 Basis');
      verify(() => mockClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).called(1);
    });

    test('Handles 300 response with similarity models', () async {
      final mockResponse = Response(jsonVehicleOptions, 300);
      final mockSimilarityModels = (jsonDecode(jsonVehicleOptions) as List)
          .map((e) => VehicleSimilarityModel.fromJson(e))
          .toList();
      when(() => mockClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => mockResponse);

      final response = await restClient.post(networkRequest);

      expect(response.similarityModels, mockSimilarityModels);
    });

    test('Handles 401 AuthenticationException for missing auth header',
        () async {
      when(() => mockClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenThrow(ClientException("Auth"));

      expect(
        () async => await restClient.post(networkRequest),
        throwsA(isA<AuthenticationException>()),
      );
    });

    test('Handles 400 error', () async {
      when(() => mockClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => Response(json400Error, 400));

      expect(
        () async => await restClient.post(networkRequest),
        throwsA(
          isA<NetworkException>().having(
              (e) => e.message, 'message', 'Please try again in 3 seconds'),
        ),
      );
    });

    test('Handles json parsing exception', () async {
      when(() => mockClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => Response('''{invalid_json}''', 400));

      expect(
        () async => await restClient.post(networkRequest),
        throwsA(
          isA<ParsingException>(),
        ),
      );
    });

    test('Handles Socket exception', () async {
      final message = "Error occurred";

      when(() => mockClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenThrow(SocketException(message));

      expect(
        () async => await restClient.post(networkRequest),
        throwsA(
          isA<NetworkException>().having(
            (state) => state.message,
            'Matching message',
            equals('No Internet connection, please check your network.'),
          ),
        ),
      );
    });

    test('Handles TimeoutException exception', () async {
      final message = "Error occurred";

      when(() => mockClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenThrow(TimeoutException(message));

      expect(
        () async => await restClient.post(networkRequest),
        throwsA(
          isA<NetworkException>().having(
            (state) => state.message,
            'Matching message',
            equals('Slow internet connection, please try again later.'),
          ),
        ),
      );
    });
  });
}
