import 'package:assignment_car_on_sale/app_routes.dart';
import 'package:assignment_car_on_sale/core/di/di_module_provider_widget.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/home_screen.dart';
import 'package:assignment_car_on_sale/feature/login/presentation/di/login_module.dart';
import 'package:flutter/material.dart';

import 'feature/login/presentation/login_screen.dart';

class AppRouteGenerator {
  AppRouteGenerator._();

  static Route onGenerateRoute(final RouteSettings settings) {
    final initialSettings = RouteSettings(
      name: settings.name,
    );
    switch (settings.name) {
      case AppRoutes.homeScreenRoute:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
          settings: initialSettings,
        );
      case AppRoutes.loginScreenRoute:
        return MaterialPageRoute(
          builder: (context) => DiModuleProviderWidget(
            module: LoginModule(),
            child: LoginScreen(),
          ),
          settings: initialSettings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Container(),
          settings: initialSettings,
        );
    }
  }
}
