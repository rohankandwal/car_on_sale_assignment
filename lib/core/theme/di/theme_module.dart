import 'dart:async';

import 'package:assignment_car_on_sale/core/di/di_module.dart';
import 'package:assignment_car_on_sale/core/theme/theme_cubit.dart';
import 'package:assignment_car_on_sale/core/utils/get_it.dart';

class ThemeModule extends DiModule {
  @override
  void dispose() {
    getIt.get<ThemeCubit>().close();
    getIt.unregister<ThemeCubit>();
  }

  @override
  FutureOr<void> setup() {
    getIt.registerLazySingleton(() => ThemeCubit());
  }
}
