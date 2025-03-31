import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_information_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_search_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_similarity_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/repository/home_repository_impl.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_information_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_search_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_similar_entity.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late MockHomeRemoteDataSource mockRemoteDataSource;
  late MockVehicleEntityMapper mockMapper;
  late HomeRepositoryImpl repository;
  const validVin = '1G1AZ123456789012';

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

  final testEntity = VehicleSearchEntity(
    vehicleInformation: VehicleInformationEntity(
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
    ),
    similarVehicles: [
      VehicleSimilarEntity(
        make: 'Tesla',
        model: 'Model 3',
        containerName: 'Container1',
        similarity: 90,
        externalId: 'TSLA456',
      ),
      VehicleSimilarEntity(
        make: 'Tesla',
        model: 'Model X',
        containerName: 'Container2',
        similarity: 85,
        externalId: 'TSLA789',
      ),
    ],
  );

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    mockMapper = MockVehicleEntityMapper();
    repository = HomeRepositoryImpl(mockRemoteDataSource, mockMapper);
  });

  group('searchVehicleByVin', () {
    test('returns Right(VehicleSearchEntity) on successful response', () async {
      when(() => mockRemoteDataSource.searchVehicleByVin(validVin))
          .thenAnswer((_) async => testModel);
      when(() => mockMapper.mapToVehicleSearchModel(testModel))
          .thenReturn(testEntity);

      final result = await repository.searchVehicleByVin(validVin);

      expect(result, Right(testEntity));
      verify(() => mockRemoteDataSource.searchVehicleByVin(validVin)).called(1);
      verify(() => mockMapper.mapToVehicleSearchModel(testModel)).called(1);
    });

    test('returns ServerFailure on BaseException', () async {
      const errorMessage = 'Server error';
      when(() => mockRemoteDataSource.searchVehicleByVin(validVin))
          .thenThrow(NetworkException(errorMessage));

      final result = await repository.searchVehicleByVin(validVin);

      expect(result, Left(ServerFailure(errorMessage)));
    });

    test('returns generic ServerFailure on unexpected error', () async {
      when(() => mockRemoteDataSource.searchVehicleByVin(validVin))
          .thenThrow(Exception('Some error'));

      final result = await repository.searchVehicleByVin(validVin);

      expect(result,
          Left(ServerFailure('An unexpected error occurred, try again later')));
    });
  });
}
