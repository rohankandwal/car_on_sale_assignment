import 'dart:async';

import 'package:assignment_car_on_sale/core/authentication/authentication_cubit.dart';
import 'package:assignment_car_on_sale/core/di/di_module.dart';
import 'package:assignment_car_on_sale/core/local_storage/shared_pref.dart';
import 'package:assignment_car_on_sale/core/utils/get_it.dart';

class AuthenticationModule extends DiModule {
  @override
  void dispose() {
    getIt.get<AuthenticationCubit>().close();
    getIt.unregister<AuthenticationCubit>();
  }

  @override
  FutureOr<void> setup() {
    final sharedPref = getIt.get<SharedPref>();
    getIt.registerLazySingleton(
      () => AuthenticationCubit(sharedPref),
    );
  }
}
