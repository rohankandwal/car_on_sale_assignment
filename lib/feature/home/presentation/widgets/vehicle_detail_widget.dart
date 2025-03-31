import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_information_entity.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/widgets/vehicle_info_row_widget.dart';
import 'package:flutter/material.dart';

class VehicleDetailWidget extends StatelessWidget {
  final VehicleInformationEntity vehicleInformation;

  const VehicleDetailWidget({
    super.key,
    required this.vehicleInformation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      child: Column(
        spacing: 8,
        children: [
          VehicleInfoRowWidget(
            title: 'ID',
            value: vehicleInformation.id.toString(),
          ),
          VehicleInfoRowWidget(
            title: 'Model',
            value: vehicleInformation.model,
          ),
          VehicleInfoRowWidget(
            title: 'Make',
            value: vehicleInformation.make,
          ),
          VehicleInfoRowWidget(
            title: 'Price',
            value: '\$${vehicleInformation.price}',
          ),
          VehicleInfoRowWidget(
            title: 'Seller',
            value: vehicleInformation.fkSellerUser,
          ),
          VehicleInfoRowWidget(
            title: 'Has positive feedback',
            value: vehicleInformation.feedback,
          ),
        ],
      ),
    );
  }
}
