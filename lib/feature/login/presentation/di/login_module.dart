import 'dart:async';

import 'package:assignment_car_on_sale/core/di/di_module.dart';
import 'package:assignment_car_on_sale/core/utils/get_it.dart';
import 'package:assignment_car_on_sale/feature/login/data/repository/login_repository_impl.dart';
import 'package:assignment_car_on_sale/feature/login/domain/repository/login_repository.dart';
import 'package:assignment_car_on_sale/feature/login/domain/usecases/login_use_case.dart';
import 'package:assignment_car_on_sale/feature/login/presentation/bloc/login_cubit.dart';

class LoginModule extends DiModule {
  @override
  void dispose() {
    getIt.get<LoginCubit>().close();
    getIt.unregister<LoginCubit>();
  }

  @override
  FutureOr<void> setup() {
    getIt.registerLazySingleton<LoginCubit>(() {
      final LoginRepository loginRepository = LoginRepositoryImpl();
      final LoginUseCase loginUseCase = LoginUseCase(loginRepository);
      return LoginCubit(loginUseCase);
    });
  }
}
