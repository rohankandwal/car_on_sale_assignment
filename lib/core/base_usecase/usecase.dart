import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:either_dart/either.dart';

abstract class UseCase<Type, Param> {
  Future<Either<BaseFailure, Type>> call(final Param param);
}

class NoParams {}
