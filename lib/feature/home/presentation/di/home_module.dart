import 'dart:async';

import 'package:assignment_car_on_sale/core/di/di_module.dart';
import 'package:assignment_car_on_sale/core/utils/get_it.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/bloc/home_cubit.dart';

class HomeModule extends DiModule {
  @override
  void dispose() {
    getIt.get<HomeCubit>().close();
    getIt.unregister<HomeCubit>();
  }

  @override
  FutureOr<void> setup() {
    getIt.registerLazySingleton(() {
      final HomeCubit homeCubit = HomeCubit();
      return homeCubit;
    });
  }
}
