import 'package:assignment_car_on_sale/core/di/di_module_provider_widget.dart';
import 'package:assignment_car_on_sale/feature/login/presentation/di/login_module.dart';
import 'package:flutter/material.dart';

import 'feature/login/presentation/login_screen.dart';

class AppRouteGenerator {
  AppRouteGenerator._();

  static Route onGenerateRoute(final RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(
          builder: (context) => DiModuleProviderWidget(
            module: LoginModuleImpl(),
            child: LoginScreen(),
          ),
        );
    }
  }
}
