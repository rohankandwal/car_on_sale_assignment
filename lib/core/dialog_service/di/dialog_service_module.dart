import 'dart:async';

import 'package:assignment_car_on_sale/core/di/di_module.dart';
import 'package:assignment_car_on_sale/core/dialog_service/progress_dialog_service.dart';
import 'package:assignment_car_on_sale/core/utils/get_it.dart';

class DialogServiceModule extends DiModule {
  @override
  void dispose() {
    getIt.unregister<ProgressDialogService>();
  }

  @override
  FutureOr<void> setup() {
    getIt.registerLazySingleton<ProgressDialogService>(
      ProgressDialogServiceImpl.new,
    );
  }
}
