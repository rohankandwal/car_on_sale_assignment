import 'dart:async';

import 'package:assignment_car_on_sale/core/di/di_module.dart';
import 'package:assignment_car_on_sale/feature/login/presentation/bloc/login_cubit.dart';

sealed class LoginModule extends DiModule {
  LoginCubit getLoginCubit();
}

class LoginModuleImpl extends LoginModule {
  late final LoginCubit _loginCubit;

  @override
  void dispose() {
    _loginCubit.close();
  }

  @override
  FutureOr<void> setup() {
    _loginCubit = LoginCubit();
  }

  @override
  LoginCubit getLoginCubit() {
    return _loginCubit;
  }
}
