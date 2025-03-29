import 'dart:async';

import 'package:assignment_car_on_sale/core/di/di_module.dart';
import 'package:assignment_car_on_sale/core/dialog_service/di/dialog_service_module.dart';

/// Module containing app wide dependencies, stuff whole lifetime should be the
/// entire lifetime of the application
class AppModule extends DiModule {
  final List<DiModule> coreModules = [
    DialogServiceModule(),
  ];

  @override
  void dispose() {
    for (final module in coreModules) {
      module.dispose();
    }
  }

  @override
  FutureOr<void> setup() async {
    for (final module in coreModules) {
      await module.setup();
    }
  }
}
