import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DecimalThousandsFormatter extends TextInputFormatter {
  final formatter = NumberFormat("#,##0.########");

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Empty input
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Allow only digits and one dot
    final cleaned = newValue.text.replaceAll(',', '');

    // If invalid decimal → block
    if (double.tryParse(cleaned) == null) {
      return oldValue;
    }

    // Split into integer + decimal
    final parts = cleaned.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // Format integer part with commas only
    integerPart = NumberFormat('#,##0').format(int.parse(integerPart));

    // Rebuild final formatted text
    String formatted = decimalPart.isNotEmpty
        ? '$integerPart.$decimalPart'
        : integerPart;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
