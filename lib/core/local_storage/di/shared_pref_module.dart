import 'dart:async';

import 'package:assignment_car_on_sale/core/di/di_module.dart';
import 'package:assignment_car_on_sale/core/local_storage/shared_pref.dart';
import 'package:assignment_car_on_sale/core/utils/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPrefModule extends DiModule {
  @override
  void dispose() {
    getIt.unregister<FlutterSecureStorage>();
  }

  @override
  FutureOr<void> setup() {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    getIt.registerLazySingleton<SharedPref>(() => SharedPrefImpl(storage));
  }
}
