import 'package:client/extensions/time_extensions.dart';
import 'package:flutter/material.dart';


abstract class Validators {
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? genericRequired<T>(T? value) {
    if (value == null || value is String && value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? requiredList<T>(List<T>? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? requiredCheckBox(bool? value) {
    if (value == null || !value) {
      return 'This field is required';
    }
    return null;
  }

  // phone
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Phone is required';
    if (value.length < 10) return 'Phone is invalid';
    return null;
  }

  // email
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!value.contains('@')) return 'Email is invalid';
    return null;
  }

  // birth date
  static String? birthDate(DateTime? value) {
    if (value == null) return 'Birth date is required';
    if (value.isAfter(DateTime.now())) return 'Birth date is invalid';
    return null;
  }

  // card expiry date
  static String? cardExpiryDate(DateTime? value) {
    if (value == null) return 'Expiry date is required';
    if (value.isBefore(DateTime.now())) return 'Expiry date is invalid';
    return null;
  }

  // end time after start time
  static String? endTimeAfterStartTime(
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  ) {
    if (startTime == null || endTime == null) return null;
    if (endTime.isBefore(startTime)) return 'End time must be after start time';
    return null;
  }

  // password
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password should be at least 8 characters';
    return null;
  }

  // confirm password
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) return 'Confirm password is required';
    if (value != password) return 'Passwords do not match';
    return null;
  }

  static String? Function(T?)? merge<T>(String? Function(T?)? validator1, String? Function(T?)? validator2) {
    return (T? value) {
      final error1 = validator1?.call(value);
      if (error1 != null) return error1;
      return validator2?.call(value);
    };
  }

  static String? Function(T?)? mergeWithRequired<T>(String? Function(T?)? validator) {
    return merge(genericRequired, validator);
  }


}
