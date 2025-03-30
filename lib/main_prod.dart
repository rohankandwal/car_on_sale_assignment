import 'package:assignment_car_on_sale/environments.dart';
import 'package:flutter/material.dart';

import 'main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApplication(Environment.prod);
}
