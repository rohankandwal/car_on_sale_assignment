import 'dart:convert';

import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/network/network_request.dart';
import 'package:assignment_car_on_sale/core/utils/string_constants.dart';
import 'package:assignment_car_on_sale/feature/home/data/datasource/home_remote_datasource.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_information_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_search_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_similarity_model.dart';
import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late MockHomeRestClient mockRestClient;
  late MockSharedPref mockSharedPref;
  late HomeRemoteDataSourceImpl dataSource;
  const testVin = '1G1AZ123456789012';
  final testUser = UserModel(token: 'test_token', name: 'test_user');
  final networkRequest =
      NetworkRequest(endPoint: "searchVehicle", requestBody: {
    "vin": testVin,
  }, headers: {
    'auth': testUser.token,
  });
  final mockInformationModel = VehicleInformationModel(
    model: 'Model S',
    make: 'Tesla',
    externalId: 'TSLA123',
    id: 1,
    createdAt: DateTime.parse('2025-01-01'),
    estimationRequestId: 'REQ123',
    feedback: 'Positive',
    fkSellerUser: 'Seller123',
    fkUuidAuction: 'Auction123',
    inspectorRequestedAt: DateTime.parse('2025-01-02'),
    origin: 'USA',
    price: 50000,
    positiveCustomerFeedback: true,
    requestedAt: DateTime.parse('2025-01-03'),
    updatedAt: DateTime.parse('2025-01-04'),
    valuatedAt: DateTime.parse('2025-01-05'),
  );

  final mockSimilarityModels = [
    VehicleSimilarityModel(
      make: 'Tesla',
      model: 'Model 3',
      containerName: 'Container1',
      similarity: 90,
      externalId: 'TSLA456',
    ),
    VehicleSimilarityModel(
      make: 'Tesla',
      model: 'Model X',
      containerName: 'Container2',
      similarity: 85,
      externalId: 'TSLA789',
    ),
  ];

  final testModel = VehicleSearchModel(
    informationModel: mockInformationModel,
    similarityModels: mockSimilarityModels,
  );

  setUp(() {
    mockRestClient = MockHomeRestClient();
    mockSharedPref = MockSharedPref();
    dataSource = HomeRemoteDataSourceImpl(mockRestClient, mockSharedPref);
    registerFallbackValue(networkRequest);
  });

  group('searchVehicleByVin', () {
    test('returns VehicleSearchModel on success', () async {
      final userJson = jsonEncode(testUser.toJson());
      when(() => mockSharedPref.getString(key: StringConstants.userInfoKey))
          .thenAnswer((_) async => userJson);
      when(
        () => mockRestClient.post(
          any(),
        ),
      ).thenAnswer((_) async => testModel);

      final result = await dataSource.searchVehicleByVin(testVin);

      expect(result, testModel);
      verify(() => mockSharedPref.getString(key: StringConstants.userInfoKey))
          .called(1);
      verify(
        () => mockRestClient.post(
          any(
            that: isA<NetworkRequest>()
                .having(
                  (r) => r.endPoint,
                  'endPoint',
                  'searchVehicle',
                )
                .having(
                  (r) => r.requestBody?['vin'],
                  'vin',
                  testVin,
                )
                .having(
                  (r) => r.headers?['auth'],
                  'auth',
                  testUser.token,
                ),
          ),
        ),
      ).called(1);
    });

    test('throws AuthenticationException when user info is missing', () async {
      when(() => mockSharedPref.getString(key: StringConstants.userInfoKey))
          .thenAnswer((_) async => null);

      expect(
        () => dataSource.searchVehicleByVin(testVin),
        throwsA(
          isA<AuthenticationException>().having((e) => e.message, 'message',
              'User information not found, please login again.'),
        ),
      );
    });

    test('propagates network exceptions', () async {
      final userJson = jsonEncode(testUser.toJson());
      final testException = NetworkException('Connection failed');

      when(() => mockSharedPref.getString(key: StringConstants.userInfoKey))
          .thenAnswer((_) async => userJson);
      when(() => mockRestClient.post(any())).thenThrow(testException);

      expect(
        () => dataSource.searchVehicleByVin(testVin),
        throwsA(testException),
      );
    });
  });
}
