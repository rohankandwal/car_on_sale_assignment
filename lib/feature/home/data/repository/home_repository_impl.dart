import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/home/data/datasource/home_remote_datasource.dart';
import 'package:assignment_car_on_sale/feature/home/data/mapper/vehicle_model_mapper.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_search_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/repository/home_repository.dart';
import 'package:either_dart/either.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final VehicleEntityMapper mapper;

  HomeRepositoryImpl(
    this.remoteDataSource,
    this.mapper,
  );

  @override
  Future<Either<BaseFailure, VehicleSearchEntity>> searchVehicleByVin(
    final String vin,
  ) async {
    try {
      final searchModel = await remoteDataSource.searchVehicleByVin(vin);
      final searchEntity = mapper.mapToVehicleSearchModel(searchModel);
      return Right(searchEntity);
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
