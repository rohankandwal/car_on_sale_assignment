import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_search_model.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_information_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_search_entity.dart';
import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_similar_entity.dart';

class VehicleEntityMapper {
  VehicleSearchEntity mapToVehicleSearchModel(
    final VehicleSearchModel searchEntity,
  ) {
    return VehicleSearchEntity(
      vehicleInformation: searchEntity.informationModel != null
          ? VehicleInformationEntity(
              model: searchEntity.informationModel!.model,
              make: searchEntity.informationModel!.make,
              externalId: searchEntity.informationModel!.externalId,
              id: searchEntity.informationModel!.id,
              createdAt: searchEntity.informationModel!.createdAt,
              estimationRequestId:
                  searchEntity.informationModel!.estimationRequestId,
              feedback: searchEntity.informationModel!.feedback,
              fkSellerUser: searchEntity.informationModel!.fkSellerUser,
              fkUuidAuction: searchEntity.informationModel!.fkUuidAuction,
              inspectorRequestedAt:
                  searchEntity.informationModel!.inspectorRequestedAt,
              origin: searchEntity.informationModel!.origin,
              price: searchEntity.informationModel!.price,
              positiveCustomerFeedback:
                  searchEntity.informationModel!.positiveCustomerFeedback,
              requestedAt: searchEntity.informationModel!.requestedAt,
              updatedAt: searchEntity.informationModel!.updatedAt,
              valuatedAt: searchEntity.informationModel!.valuatedAt,
            )
          : null,
      similarVehicles: searchEntity.similarityModels?.map((similarModel) {
        return VehicleSimilarEntity(
          make: similarModel.make,
          containerName: similarModel.containerName,
          externalId: similarModel.externalId,
          model: similarModel.model,
          similarity: similarModel.similarity,
        );
      }).toList(),
    );
  }
}
