import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_information_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_search_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_similar_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/usecases/search_vehicle_by_vin_use_case.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late MockHomeRepository mockRepository;
  late SearchVehicleByVinUseCase useCase;
  const validVin = '1G1AZ123456789012';
  const invalidVin = 'INVALID';

  final vehicleInformation = VehicleInformationEntity(
    id: 123456,
    feedback: "Please modify the price.",
    valuatedAt: DateTime.now(),
    requestedAt: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    make: "Toyota",
    model: "GT 86 Basis",
    externalId: "DE003-018601450020008",
    fkSellerUser: "25475e37-6973-483b-9b15-cfee721fc29f",
    price: 123456,
    positiveCustomerFeedback: true,
    fkUuidAuction: "3e255ad2-36d4-4048-a962-5e84e27bfa6e",
    inspectorRequestedAt: DateTime.now(),
    origin: "AUCTION",
    estimationRequestId: "3a295387d07f",
  );

  final vehicleSimilar = VehicleSimilarEntity(
    make: 'Toyota',
    model: 'GT 86 Basis',
    containerName: 'DE - Cp2 2.0 EU5, 2012 - 2015',
    similarity: 100,
    externalId: 'DE001-018601450020001',
  );

  final testVehicle = VehicleSearchEntity(
    vehicleInformation: vehicleInformation,
    similarVehicles: [
      vehicleSimilar,
    ],
  );

  final testFailure = ServerFailure('Server error');

  setUp(() {
    mockRepository = MockHomeRepository();
    useCase = SearchVehicleByVinUseCase(mockRepository);

    when(() => mockRepository.searchVehicleByVin(validVin))
        .thenAnswer((_) async => Right(testVehicle));

    when(() => mockRepository.searchVehicleByVin(invalidVin))
        .thenAnswer((_) async => Left(testFailure));
  });

  group('SearchVehicleByVinUseCase', () {
    test('returns VehicleSearchEntity on valid VIN', () async {
      final result = await useCase.call(VehicleParam(validVin));

      expect(result, Right(testVehicle));
      verify(() => mockRepository.searchVehicleByVin(validVin)).called(1);
    });

    test('returns BaseFailure on invalid response', () async {
      final result = await useCase.call(VehicleParam(invalidVin));

      expect(result, Left(testFailure));
      verify(() => mockRepository.searchVehicleByVin(invalidVin)).called(1);
    });

    test('passes correct parameters to repository', () async {
      await useCase.call(VehicleParam(validVin));

      verify(() => mockRepository.searchVehicleByVin(validVin)).called(1);
    });
  });
}
