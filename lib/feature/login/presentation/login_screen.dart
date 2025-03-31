import 'package:assignment_car_on_sale/app_routes.dart';
import 'package:assignment_car_on_sale/core/dialog_service/progress_dialog_service.dart';
import 'package:assignment_car_on_sale/core/utils/get_it.dart';
import 'package:assignment_car_on_sale/feature/login/presentation/bloc/login_cubit.dart';
import 'package:assignment_car_on_sale/feature/login/presentation/bloc/login_state.dart';
import 'package:assignment_car_on_sale/feature/login/presentation/widgets/background_widget.dart';
import 'package:assignment_car_on_sale/feature/login/presentation/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginCubit cubit = getIt.get<LoginCubit>();
  final ProgressDialogService progressDialogService =
      getIt.get<ProgressDialogService>();
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: BlocListener<LoginCubit, LoginState>(
        bloc: cubit,
        listener: (context, state) {
          progressDialogService.hideLoadingDialog(context);
          if (state is LoginErrorState) {
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
          } else if (state is LoginLoadingState) {
            progressDialogService.showLoadingDialog(context);
          } else if (state is LoginSuccessState) {
            Navigator.popAndPushNamed(context, AppRoutes.homeScreenRoute);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const BackgroundWidget(),
              LoginWidget(
                emailController: _loginEmailController,
                passwordController: _loginPasswordController,
              ),
              SizedBox(
                height: 48,
              ),
              ElevatedButton(
                onPressed: () {
                  cubit.loginNow(
                    email: _loginEmailController.text,
                    password: _loginPasswordController.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 50,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: theme.colorScheme.primary,
                ),
                child: Text(
                  "Login Now",
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    super.dispose();
  }
}
