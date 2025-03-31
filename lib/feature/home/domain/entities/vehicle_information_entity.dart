import 'package:equatable/equatable.dart';

class VehicleInformationEntity extends Equatable {
  final int id;
  final String feedback;
  final DateTime valuatedAt;
  final DateTime requestedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String make;
  final String model;
  final String externalId;
  final String fkSellerUser;
  final int price;
  final bool positiveCustomerFeedback;
  final String fkUuidAuction;
  final DateTime inspectorRequestedAt;
  final String origin;
  final String estimationRequestId;

  const VehicleInformationEntity({
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

  @override
  List<Object?> get props => [
        id,
        feedback,
        valuatedAt,
        requestedAt,
        createdAt,
        updatedAt,
        make,
        model,
        externalId,
        fkSellerUser,
        price,
        positiveCustomerFeedback,
        fkUuidAuction,
        inspectorRequestedAt,
        origin,
        estimationRequestId,
      ];
}
