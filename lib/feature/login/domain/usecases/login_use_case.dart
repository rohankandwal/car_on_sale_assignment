import 'package:assignment_car_on_sale/core/base_usecase/usecase.dart';
import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/login/domain/repository/login_repository.dart';
import 'package:either_dart/either.dart';

class LoginUseCase extends UseCase<bool, LoginParams> {
  final LoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  @override
  Future<Either<BaseFailure, bool>> call(final LoginParams param) {
    return _loginRepository.login(email: param.email, password: param.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
