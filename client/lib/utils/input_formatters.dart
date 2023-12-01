import 'dart:math';

import 'package:flutter/services.dart';

abstract class InputFormatters {
  static TextInputFormatter phone = FilteringTextInputFormatter.digitsOnly;
}

class NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final hasEmptySpace = newValue.text.trim() == oldValue.text;
    if (hasEmptySpace) {
      return TextEditingValue(
        text: newValue.text.trim(),
        selection: oldValue.selection,
      );
    }
    return newValue;
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    if (newText.length < oldValue.text.length) return newValue;

    var result = '';

    if (newText.contains('/')) {
      final dates = newText.split('/');
      final month = dates.first;
      final year = dates.last;
      if (year.length >= 2) {
        result = '$month/${year.substring(0, 2)}';
      } else {
        result = newText;
      }
    } else {
      if (newText.length == 2) {
        result = '$newText/';
      } else {
        result = newText;
      }
    }

    return newValue.copyWith(
      text: result,
      selection: TextSelection.fromPosition(
        TextPosition(offset: result.length),
      ),
    );
  }
}

class CvvFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    if (newText.length < oldValue.text.length) return newValue;

    var result = '';

    if (newText.length == 3) {
      result = newText;
    } else {
      result = newText.substring(0, min(3, newText.length));
    }

    result = int.tryParse(result) == null ? '' : result;

    return newValue.copyWith(
      text: result,
      selection: TextSelection.fromPosition(
        TextPosition(offset: result.length),
      ),
    );
  }
}
