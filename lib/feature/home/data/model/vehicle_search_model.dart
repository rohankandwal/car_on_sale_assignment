import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_information_model.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_similarity_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_search_model.g.dart';

@JsonSerializable()
class VehicleSearchModel {
  final VehicleInformationModel? informationModel;
  final List<VehicleSimilarityModel>? similarityModels;

  VehicleSearchModel({
    this.informationModel,
    this.similarityModels,
  });

  factory VehicleSearchModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleSearchModelToJson(this);
}
