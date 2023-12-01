import 'package:client/assets/fonts.gen.dart';
import 'package:client/theme/colors.dart';
import 'package:flutter/material.dart';



class AppTheme {
  static const defaultButtonTextStyle = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  static const colors = AppColors.light;

  static ThemeData lightTheme = ThemeData(
    fontFamily: FontFamily.inter,
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.primary,
      secondary: colors.secondary,
      error: colors.error,
      outline: colors.stroke,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: defaultButtonTextStyle,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colors.primary,
        textStyle: defaultButtonTextStyle,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.textPrimary,
        side: BorderSide(color: colors.strokeDarker),
        textStyle: defaultButtonTextStyle,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      shadowColor: Colors.black45,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        fontFamily: FontFamily.inter,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: FontFamily.inter,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: colors.textSecondary,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(colors.primary),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.black45,
      titleTextStyle: TextStyle(
        fontFamily: FontFamily.inter,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      contentTextStyle: TextStyle(
        fontFamily: FontFamily.inter,
        fontSize: 16,
        color: colors.textSecondary,
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black45,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return colors.primary;
        }
        return null;
      }),
      checkColor: MaterialStateProperty.all(Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      visualDensity: VisualDensity.comfortable,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      side: BorderSide(
        color: colors.strokeDarker,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: colors.stroke,
      thickness: 1,
      space: 0,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: colors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: colors.textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors.textPrimary,
      ),
      labelLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: colors.textSecondary,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: colors.textSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: colors.textSecondary,
      ),
    ),
  );
}
