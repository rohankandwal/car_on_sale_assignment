import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/home/data/datasource/home_remote_datasource.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_search_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/repository/home_repository.dart';
import 'package:either_dart/either.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<BaseFailure, VehicleSearchEntity>> searchVehicleByVin(
    final String vin,
  ) async {
    try {
      await remoteDataSource.searchVehicleByVin(vin);
      throw UnimplementedError();
    } on BaseException catch (e) {
      return Left(
        ServerFailure(e.message),
      );
    } catch (e) {
      return Left(
        ServerFailure('An unexpected error occurred, try again later'),
      );
    }
  }
}
