import 'dart:async';

import 'package:assignment_car_on_sale/core/di/di_module.dart';

/// Module containing app wide dependencies, stuff whole lifetime should be the
/// entire lifetime of the application
class AppModule extends DiModule {
  @override
  void dispose() {}

  @override
  FutureOr<void> setup() {}
}
