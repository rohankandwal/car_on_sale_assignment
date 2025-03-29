import 'package:flutter/services.dart';

/// Input formatter to limit adding space in the text fields
class SpaceLimitingFormatter extends FilteringTextInputFormatter {
  SpaceLimitingFormatter.deny() : super.deny(RegExp(r'\s'));
}
