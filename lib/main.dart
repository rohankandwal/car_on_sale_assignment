import 'package:assignment_car_on_sale/app_module.dart';
import 'package:assignment_car_on_sale/app_route_generator.dart';
import 'package:assignment_car_on_sale/core/config/env_constants.dart';
import 'package:assignment_car_on_sale/core/utils/pretty_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'environments.dart';

Future runApplication(final Environment environment) async {
  Bloc.observer = PrettyBlocObserver();
  EnvConstants.setEnvironment(environment);
  await AppModule().setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarOnSale demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: AppRouteGenerator.onGenerateRoute,
    );
  }
}
