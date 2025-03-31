import 'dart:convert';

import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/utils/string_constants.dart';
import 'package:assignment_car_on_sale/feature/home/data/datasource/home_local_data_source.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_information_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_search_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_similarity_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late MockSharedPref mockSharedPref;
  late HomeLocalDataSourceImpl dataSource;
  const testVin = '1G1AZ123456789012';
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
    mockSharedPref = MockSharedPref();
    dataSource = HomeLocalDataSourceImpl(mockSharedPref);
  });

  group('getVehicleInformationByVin', () {
    test('returns VehicleInformationModel when data exists', () async {
      final jsonString = jsonEncode(testModel.toJson());
      when(() => mockSharedPref.getString(key: testVin)).thenAnswer(
        (_) async => jsonString,
      );

      final result = await dataSource.getVehicleInformationByVin(testVin);

      expect(result, isA<VehicleSearchModel>());
      expect(result?.informationModel!.id, 1);
      verify(() => mockSharedPref.getString(key: testVin)).called(1);
    });

    test('returns null when no data exists', () async {
      when(() => mockSharedPref.getString(key: testVin))
          .thenAnswer((_) async => null);

      final result = await dataSource.getVehicleInformationByVin(testVin);

      expect(result, isNull);
    });

    test('throws ParsingException on invalid JSON', () async {
      when(() => mockSharedPref.getString(key: testVin))
          .thenAnswer((_) async => '{invalid_json}');

      expect(() => dataSource.getVehicleInformationByVin(testVin),
          throwsA(isA<ParsingException>()));
    });
  });

  group('saveVehicleInformation', () {
    test('saves valid JSON string with correct key', () async {
      final expectedJson = jsonEncode(testModel.toJson());
      when(() => mockSharedPref.saveString(
            key: testVin,
            data: expectedJson,
          )).thenAnswer((_) async => {});

      await dataSource.saveVehicleInformation(testModel, testVin);

      verify(() => mockSharedPref.saveString(
            key: testVin,
            data: expectedJson,
          )).called(1);
    });
  });

  group('getVehicleInformationSavedTimeStamp', () {
    test('returns timestamp with correct key suffix', () async {
      const timestampKey = '$testVin${StringConstants.timeStamp}';
      const timestamp = '2025-03-31T15:27:00Z';
      when(() => mockSharedPref.getString(key: timestampKey))
          .thenAnswer((_) async => timestamp);

      final result =
          await dataSource.getVehicleInformationSavedTimeStamp(testVin);

      expect(result, timestamp);
      verify(() => mockSharedPref.getString(key: timestampKey)).called(1);
    });
  });
}
