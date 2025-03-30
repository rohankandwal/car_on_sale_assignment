import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/login/data/datasource/login_remote_data_source.dart';
import 'package:assignment_car_on_sale/feature/login/domain/repository/login_repository.dart';
import 'package:either_dart/either.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource _remoteDataSource;

  LoginRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<BaseFailure, bool>> login({
    required final String email,
    required final String password,
  }) async {
    try {
      await _remoteDataSource.login(email: email, password: password);
      return Right(true);
    } on BaseException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
