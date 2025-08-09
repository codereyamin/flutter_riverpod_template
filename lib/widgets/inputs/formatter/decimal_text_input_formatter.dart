import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (RegExp(r'^\d*\.?\d*$').hasMatch(text)) {
      return newValue;
    }

    return oldValue;
  }
}
