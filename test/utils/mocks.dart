import 'package:assignment_car_on_sale/core/local_storage/shared_pref.dart';
import 'package:assignment_car_on_sale/feature/home/data/datasource/home_remote_datasource.dart';
import 'package:assignment_car_on_sale/feature/home/data/mapper/vehicle_model_mapper.dart';
import 'package:assignment_car_on_sale/feature/home/data/repository/home_repository_impl.dart';
import 'package:assignment_car_on_sale/feature/home/domain/usecases/search_vehicle_by_vin_use_case.dart';
import 'package:assignment_car_on_sale/feature/login/data/datasource/login_local_data_source.dart';
import 'package:assignment_car_on_sale/feature/login/data/datasource/login_remote_data_source.dart';
import 'package:assignment_car_on_sale/feature/login/data/network/rest_client.dart';
import 'package:assignment_car_on_sale/feature/login/domain/repository/login_repository.dart';
import 'package:assignment_car_on_sale/feature/login/domain/usecases/login_use_case.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as auth_handler;
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockLoginRepository extends Mock implements LoginRepository {}

class MockLoginRemoteDataSource extends Mock
    implements LoginRemoteDataSourceImpl {}

class MockRestClient extends Mock implements RestClientImpl {}

class MockHttpAuthenticationHandler extends Mock
    implements auth_handler.BaseClient {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockSharedPref extends Mock implements SharedPrefImpl {}

class MockLoginLocalDataSource extends Mock
    implements LoginLocalDataSourceImpl {}

class MockSearchVehicleByVinUseCase extends Mock
    implements SearchVehicleByVinUseCase {}

class MockHomeRepository extends Mock implements HomeRepositoryImpl {}

class MockHomeRemoteDataSource extends Mock
    implements HomeRemoteDataSourceImpl {}

class MockVehicleEntityMapper extends Mock implements VehicleEntityMapper {}
