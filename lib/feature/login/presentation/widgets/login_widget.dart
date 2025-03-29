import 'package:assignment_car_on_sale/core/utils/space_limiting_formatter.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginWidget({
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
        ),
        child: Column(
          children: [
            TextFormField(
              maxLines: 1,
              controller: widget.emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                fontSize: 16.0,
              ),
              inputFormatters: [
                SpaceLimitingFormatter.deny(),
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.mail,
                  size: 22.0,
                ),
                label: Text('Email Address'),
                labelStyle: TextStyle(fontSize: 16.0),
              ),
              textInputAction: TextInputAction.next,
            ),
            Divider(
              color: Theme.of(context).colorScheme.primary,
            ),
            TextFormField(
              maxLines: 1,
              controller: widget.passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscurePassword,
              inputFormatters: [
                SpaceLimitingFormatter.deny(),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.lock,
                  color: Theme.of(context).colorScheme.primary,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                label: Text('Password'),
                labelStyle: TextStyle(fontSize: 16.0),
              ),
              textInputAction: TextInputAction.next,
            ),
          ],
        ),
      ),
    );
  }
}
