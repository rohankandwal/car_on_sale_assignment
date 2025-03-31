import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_information_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_search_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_similar_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/usecases/search_vehicle_by_vin_use_case.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/bloc/home_cubit.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/bloc/home_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_valid/is_valid.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late MockSearchVehicleByVinUseCase mockUseCase;
  late HomeCubit homeCubit;

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
    mockUseCase = MockSearchVehicleByVinUseCase();
    homeCubit = HomeCubit(mockUseCase);
    registerFallbackValue(VehicleParam('vin'));
  });

  tearDown(() => homeCubit.close());

  group('HomeCubit Tests', () {
    blocTest<HomeCubit, HomeState>(
      'emits [Loading, Error] for invalid VIN',
      build: () => homeCubit,
      act: (cubit) => cubit.searchVin('INVALID'),
      expect: () => [
        isA<HomeLoadingState>(),
        isA<HomeErrorState>().having(
          (s) => s.message,
          'message',
          'Pin isn\'t valid, please use pin like 1G1AZ123456789012',
        )
      ],
      verify: (_) => verifyNever(
        () => mockUseCase.call(
          any(),
        ),
      ),
    );

    blocTest<HomeCubit, HomeState>('emits [Loading, Success] with vehicle data',
        build: () {
          when(() => mockUseCase.call(any()))
              .thenAnswer((_) async => Right(testVehicle));
          return homeCubit;
        },
        act: (cubit) => cubit.searchVin('1G1AZ123456789012'),
        expect: () => [
              isA<HomeLoadingState>(),
              isA<HomeSuccessVinState>().having(
                (s) => s.vehicleSearch,
                'vehicle',
                testVehicle,
              )
            ],
        verify: (_) => verify(() => mockUseCase.call(any())).called(1));

    blocTest<HomeCubit, HomeState>(
      'emits [Loading, Error] for server failure',
      build: () {
        when(() => mockUseCase.call(any()))
            .thenAnswer((_) async => Left(testFailure));
        return homeCubit;
      },
      act: (cubit) => cubit.searchVin('1G1AZ123456789012'),
      expect: () => [
        isA<HomeLoadingState>(),
        isA<HomeErrorState>().having(
          (s) => s.message,
          'message',
          testFailure.message,
        )
      ],
    );
  });

  test('Verify VIN validation', () {
    expect(IsValid.validateVIN(vin: '1G1AZ123456789012', vinLength: 17), true);
    expect(IsValid.validateVIN(vin: 'TSLAZ12345678901', vinLength: 17), false);
    expect(IsValid.validateVIN(vin: '123', vinLength: 17), false);
  });
}
