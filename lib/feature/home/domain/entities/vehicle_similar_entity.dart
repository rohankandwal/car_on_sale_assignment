import 'package:equatable/equatable.dart';

class VehicleSimilarEntity extends Equatable {
  final String make;
  final String model;
  final String containerName;
  final int similarity;
  final String externalId;

  const VehicleSimilarEntity({
    required this.make,
    required this.model,
    required this.containerName,
    required this.similarity,
    required this.externalId,
  });

  @override
  List<Object?> get props => [
        make,
        model,
        containerName,
        similarity,
        externalId,
      ];
}
