import 'package:assignment_car_on_sale/feature/login/presentation/widgets/background_widget.dart';
import 'package:assignment_car_on_sale/feature/login/presentation/widgets/login_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 50,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: theme.primaryColor,
              ),
              child: Text(
                "Login Now",
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            )
          ],
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
