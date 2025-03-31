import 'package:assignment_car_on_sale/app_routes.dart';
import 'package:assignment_car_on_sale/core/authentication/authentication_cubit.dart';
import 'package:assignment_car_on_sale/core/utils/get_it.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.canvasColor,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.person_2_rounded,
            size: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Hi User',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              getIt.get<AuthenticationCubit>().logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.loginScreenRoute,
                (route) => false,
              );
            },
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
