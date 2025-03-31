import 'package:assignment_car_on_sale/feature/home/data/mapper/vehicle_model_mapper.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_information_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_search_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_similarity_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mapper = VehicleEntityMapper();
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

  group('VehicleEntityMapper Tests', () {
    test('maps complete VehicleSearchModel correctly', () {
      final model = VehicleSearchModel(
        informationModel: mockInformationModel,
        similarityModels: mockSimilarityModels,
      );

      final entity = mapper.mapToVehicleSearchModel(model);

      expect(entity.vehicleInformation, isNotNull);
      expect(entity.vehicleInformation!.model, 'Model S');
      expect(entity.vehicleInformation!.price, 50000);
      expect(entity.similarVehicles!.length, 2);
      expect(entity.similarVehicles!.first.containerName, 'Container1');
    });

    test('handles null informationModel', () {
      final model = VehicleSearchModel(
        informationModel: null,
        similarityModels: mockSimilarityModels,
      );

      final entity = mapper.mapToVehicleSearchModel(model);

      expect(entity.vehicleInformation, isNull);
      expect(entity.similarVehicles!.length, 2);
    });

    test('handles null similarityModels', () {
      final model = VehicleSearchModel(
        informationModel: mockInformationModel,
        similarityModels: null,
      );

      final entity = mapper.mapToVehicleSearchModel(model);

      expect(entity.similarVehicles, isNull);
    });

    test('handles empty similarityModels', () {
      final model = VehicleSearchModel(
        informationModel: mockInformationModel,
        similarityModels: [],
      );

      final entity = mapper.mapToVehicleSearchModel(model);

      expect(entity.similarVehicles, isEmpty);
    });

    test('handles all null values', () {
      final model = VehicleSearchModel(
        informationModel: null,
        similarityModels: null,
      );

      final entity = mapper.mapToVehicleSearchModel(model);

      expect(entity.vehicleInformation, isNull);
      expect(entity.similarVehicles, isNull);
    });

    test('correctly maps DateTime fields', () {
      final model = VehicleSearchModel(
        informationModel: mockInformationModel,
        similarityModels: [],
      );

      final entity = mapper.mapToVehicleSearchModel(model);

      expect(entity.vehicleInformation!.createdAt, DateTime(2025, 1, 1));
      expect(entity.vehicleInformation!.valuatedAt, DateTime(2025, 1, 5));
    });
  });
}
