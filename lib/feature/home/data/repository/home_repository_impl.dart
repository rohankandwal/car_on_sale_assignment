import 'package:assignment_car_on_sale/core/exceptions/exceptions.dart';
import 'package:assignment_car_on_sale/core/failures/failures.dart';
import 'package:assignment_car_on_sale/feature/home/data/datasource/home_local_data_source.dart';
import 'package:assignment_car_on_sale/feature/home/data/datasource/home_remote_datasource.dart';
import 'package:assignment_car_on_sale/feature/home/data/mapper/vehicle_model_mapper.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_search_model.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_search_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/repository/home_repository.dart';
import 'package:either_dart/either.dart';

/// Maximum cache time in milliseconds
const cacheTime = 60 * 1000;

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final VehicleEntityMapper mapper;

  HomeRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.mapper,
  );

  @override
  Future<Either<BaseFailure, VehicleSearchEntity>> searchVehicleByVin(
    final String vin,
  ) async {
    try {
      final savedTimeStamp =
          await localDataSource.getVehicleInformationSavedTimeStamp(vin);
      if (savedTimeStamp != null) {
        final savedTime = DateTime.parse(savedTimeStamp);
        final currentTime = DateTime.now();
        if (currentTime.difference(savedTime).inMilliseconds < cacheTime) {
          final cachedData =
              await localDataSource.getVehicleInformationByVin(vin);
          if (cachedData != null) {
            final searchEntity = mapper.mapToVehicleSearchModel(cachedData);
            return Right(searchEntity);
          }
        }
      }
      final result = await remoteDataSource.searchVehicleByVin(vin);

      /// Sort the similarity models by similarity in descending order
      final sortedSimilarityModels = result.similarityModels?.toList()
        ?..sort((a, b) => b.similarity.compareTo(a.similarity));
      final searchModel = VehicleSearchModel(
        informationModel: result.informationModel,
        similarityModels: sortedSimilarityModels,
      );
      localDataSource.saveVehicleInformation(searchModel, vin);
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
