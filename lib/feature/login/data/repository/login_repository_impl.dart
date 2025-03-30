import 'package:assignment_car_on_sale/core/base_failures/base_failures.dart';
import 'package:assignment_car_on_sale/feature/login/domain/repository/login_repository.dart';
import 'package:either_dart/either.dart';

class LoginRepositoryImpl extends LoginRepository {
  @override
  Future<Either<BaseFailure, bool>> login({
    required final String email,
    required final String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
