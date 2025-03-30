import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:either_dart/either.dart';

abstract class LoginRepository {
  /// Function to login the user via email/pwd combo
  Future<Either<BaseFailure, bool>> login({
    required final String email,
    required final String password,
  });
}
