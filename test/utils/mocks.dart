import 'package:assignment_car_on_sale/feature/login/domain/repository/login_repository.dart';
import 'package:assignment_car_on_sale/feature/login/domain/usecases/login_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockLoginRepository extends Mock implements LoginRepository {}
