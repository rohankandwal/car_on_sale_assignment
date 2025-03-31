import 'package:assignment_car_on_sale/core/dialog_service/progress_dialog_service.dart';
import 'package:assignment_car_on_sale/core/theme/theme_cubit.dart';
import 'package:assignment_car_on_sale/core/utils/get_it.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/bloc/home_cubit.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/bloc/home_state.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/widgets/navigation_drawer_widget.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/widgets/vehicle_information_widget.dart';
import 'package:assignment_car_on_sale/feature/home/presentation/widgets/vehicle_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _vinController = TextEditingController();
  final HomeCubit homeCubit = getIt.get<HomeCubit>();
  final ThemeCubit themeCubit = getIt.get<ThemeCubit>();
  final ProgressDialogService progressDialogService =
      getIt.get<ProgressDialogService>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentTheme = themeCubit.state;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CarOnSale",
          style: TextStyle(
            color: theme.colorScheme.primary,
          ),
        ),
        iconTheme: IconThemeData(
          color: theme.colorScheme.primary,
        ),
        actions: [
          PopupMenuButton<ThemeState>(
            onSelected: (selectedTheme) {
              final themeCubit = getIt.get<ThemeCubit>();
              themeCubit.setTheme(selectedTheme); // Change the theme
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ThemeState.light,
                child: Row(
                  children: [
                    Text('Light Theme'),
                    if (currentTheme == ThemeState.light)
                      Icon(Icons.check, color: theme.colorScheme.primary),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ThemeState.dark,
                child: Row(
                  children: [
                    Text('Dark Theme'),
                    if (currentTheme == ThemeState.dark)
                      Icon(Icons.check, color: theme.colorScheme.primary),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: NavigationDrawerWidget(),
      body: BlocListener<HomeCubit, HomeState>(
        bloc: homeCubit,
        listener: (context, state) {
          progressDialogService.hideLoadingDialog(context);
          if (state is HomeErrorState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: TextStyle(
                    color: theme.colorScheme.onError,
                  ),
                ),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          } else if (state is HomeLoadingState) {
            progressDialogService.showLoadingDialog(context);
          }
        },
        child: Column(
          children: [
            VehicleSearchWidget(
                vinController: _vinController,
                onSearch: () {
                  homeCubit.searchVin(_vinController.text);
                }),
            Expanded(child: VehicleInformationWidget()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _vinController.dispose();
    super.dispose();
  }
}
