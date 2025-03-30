import 'package:assignment_car_on_sale/environments.dart';

/// Class containing the environment. It could also be used to load environment
/// specific secret keys, etc.
class EnvConstants {
  static late final Environment? environment;

  static void setEnvironment(Environment env) {
    environment = env;
  }
}
