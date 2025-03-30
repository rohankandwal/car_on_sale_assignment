import 'package:assignment_car_on_sale/feature/login/data/datasource/login_remote_data_source.dart';
import 'package:assignment_car_on_sale/feature/login/data/network/rest_client.dart';
import 'package:assignment_car_on_sale/feature/login/domain/repository/login_repository.dart';
import 'package:assignment_car_on_sale/feature/login/domain/usecases/login_use_case.dart';
import 'package:http/http.dart' as auth_handler;
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockLoginRepository extends Mock implements LoginRepository {}

class MockLoginRemoteDataSource extends Mock
    implements LoginRemoteDataSourceImpl {}

class MockRestClient extends Mock implements RestClient {}

class MockHttpAuthenticationHandler extends Mock
    implements auth_handler.BaseClient {}
