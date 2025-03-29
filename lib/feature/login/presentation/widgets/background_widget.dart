import 'package:assignment_car_on_sale/core/utils/image_constants.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageConstants.loginBackgroundImage,
      fit: BoxFit.fitWidth,
    );
  }
}
