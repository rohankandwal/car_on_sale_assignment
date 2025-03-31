import 'package:json_annotation/json_annotation.dart';

part 'vehicle_information_model.g.dart';

@JsonSerializable()
class VehicleInformationModel {
  final int id;
  final String feedback;
  final DateTime valuatedAt;
  final DateTime requestedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String make;
  final String model;
  final String externalId;
  @JsonKey(name: '_fk_sellerUser')
  final String fkSellerUser;
  final int price;
  final bool positiveCustomerFeedback;
  @JsonKey(name: '_fk_uuid_auction')
  final String fkUuidAuction;
  final DateTime inspectorRequestedAt;
  final String origin;
  final String estimationRequestId;

  VehicleInformationModel({
    required this.id,
    required this.feedback,
    required this.valuatedAt,
    required this.requestedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.make,
    required this.model,
    required this.externalId,
    required this.fkSellerUser,
    required this.price,
    required this.positiveCustomerFeedback,
    required this.fkUuidAuction,
    required this.inspectorRequestedAt,
    required this.origin,
    required this.estimationRequestId,
  });

  factory VehicleInformationModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleInformationModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleInformationModelToJson(this);
}
