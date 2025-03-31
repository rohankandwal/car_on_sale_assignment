import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_similarity_model.g.dart';

@JsonSerializable()
class VehicleSimilarityModel extends Equatable {
  final String make;
  final String model;
  final String containerName;
  final int similarity;
  final String externalId;

  const VehicleSimilarityModel({
    required this.make,
    required this.model,
    required this.containerName,
    required this.similarity,
    required this.externalId,
  });

  factory VehicleSimilarityModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleSimilarityModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleSimilarityModelToJson(this);

  @override
  List<Object?> get props => [
        make,
        model,
        containerName,
        similarity,
        externalId,
      ];
}
