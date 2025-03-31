import 'package:assignment_car_on_sale/feature/home/domain/entities/vehicle_similar_entity.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/widgets/vehicle_info_row_widget.dart';
import 'package:flutter/material.dart';

class VehicleSimilarWidget extends StatelessWidget {
  final List<VehicleSimilarEntity> vehicleSimilar;

  const VehicleSimilarWidget({
    super.key,
    required this.vehicleSimilar,
  });

  @override
  Widget build(BuildContext context) {
    if (vehicleSimilar.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: vehicleSimilar.length,
        itemBuilder: (context, index) {
          final vehicle = vehicleSimilar[index];
          return Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: Column(
              spacing: 4,
              children: [
                VehicleInfoRowWidget(
                    title: "Container Name", value: vehicle.containerName),
                VehicleInfoRowWidget(title: "Model", value: vehicle.model),
                VehicleInfoRowWidget(title: "Make", value: vehicle.make),
                VehicleInfoRowWidget(title: "ID", value: vehicle.externalId),
                VehicleInfoRowWidget(
                    title: "Similarity", value: vehicle.similarity.toString()),
              ],
            ),
          );
        },
      );
    }
    return const Text('No similar cars found');
  }
}
