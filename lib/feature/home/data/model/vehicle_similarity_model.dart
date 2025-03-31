import 'package:json_annotation/json_annotation.dart';

part 'vehicle_similarity_model.g.dart';

@JsonSerializable()
class VehicleSimilarityModel {
  final String make;
  final String model;
  final String containerName;
  final int similarity;
  final String externalId;

  VehicleSimilarityModel(
    this.make,
    this.model,
    this.containerName,
    this.similarity,
    this.externalId,
  );

  factory VehicleSimilarityModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleSimilarityModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleSimilarityModelToJson(this);
}
