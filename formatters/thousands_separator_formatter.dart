import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final formatter = NumberFormat.decimalPattern(); // adds commas

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If empty → return empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove all commas
    String cleaned = newValue.text.replaceAll(',', '');

    // If only numbers
    if (int.tryParse(cleaned) == null) {
      return oldValue; // block invalid input
    }

    // Format with commas
    String formatted = formatter.format(int.parse(cleaned));

    // Put cursor at end
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
