import 'package:assignment_car_on_sale/core/utils/get_it.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/bloc/home_cubit.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/bloc/home_state.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/widgets/vehicle_detail_widget.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/widgets/vehicle_similar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleInformationWidget extends StatelessWidget {
  const VehicleInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: getIt.get<HomeCubit>(),
      builder: (context, state) {
        if (state is HomeSuccessVinState) {
          final Widget childWidget;
          if (state.vehicleSearch.vehicleInformation != null) {
            childWidget = VehicleDetailWidget(
              vehicleInformation: state.vehicleSearch.vehicleInformation!,
            );
          } else {
            childWidget = VehicleSimilarWidget(
              vehicleSimilar: state.vehicleSearch.similarVehicles!,
            );
          }
          return childWidget;
        } else {
          return SizedBox();
        }
      },
    );
  }
}
