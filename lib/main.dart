import 'package:assignment_car_on_sale/app_module.dart';
import 'package:assignment_car_on_sale/app_route_generator.dart';
import 'package:flutter/material.dart';

enum Environment {
  dev("https://dev.example.org/v1"),
  prod("https://example.org/v1");

  final String baseUrl;

  const Environment(this.baseUrl);
}

Future runApplication(final Environment environment) async {
  AppModule().setup();
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
