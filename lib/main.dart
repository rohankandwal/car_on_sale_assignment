import 'package:assignment_car_on_sale/app_module.dart';
import 'package:assignment_car_on_sale/app_route_generator.dart';
import 'package:assignment_car_on_sale/app_routes.dart';
import 'package:assignment_car_on_sale/core/authentication/authentication_cubit.dart';
import 'package:assignment_car_on_sale/core/authentication/authentication_state.dart';
import 'package:assignment_car_on_sale/core/config/env_constants.dart';
import 'package:assignment_car_on_sale/core/theme/theme_cubit.dart';
import 'package:assignment_car_on_sale/core/utils/get_it.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      bloc: getIt.get<AuthenticationCubit>()..checkIfUserAuthenticated(),
      listener: (context, state) {
        if (state is UserAuthorizedState) {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppRoutes.homeScreenRoute,
            (route) => false,
          );
        }
      },
      child: BlocBuilder<ThemeCubit, ThemeState>(
        bloc: getIt.get<ThemeCubit>(),
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner:
                EnvConstants.environment == Environment.dev,
            navigatorKey: navigatorKey,
            title: 'CarOnSale demo',
            theme: themeState == ThemeState.light ? lightTheme : darkTheme,
            initialRoute: AppRoutes.loginScreenRoute,
            onGenerateRoute: AppRouteGenerator.onGenerateRoute,
          );
        },
      ),
    );
  }
}
