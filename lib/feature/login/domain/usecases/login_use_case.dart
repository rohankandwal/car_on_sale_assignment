import 'package:assignment_car_on_sale/core/base_failures/base_failures.dart';
import 'package:assignment_car_on_sale/core/base_usecase/usecase.dart';
import 'package:either_dart/either.dart';

class LoginUseCase extends UseCase<bool, LoginParams> {
  @override
  Future<Either<BaseFailure, bool>> call(final LoginParams param) async {
    await Future.delayed(Duration(seconds: 5));
    return Right(true);
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
