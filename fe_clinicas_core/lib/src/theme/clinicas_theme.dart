import 'package:flutter/material.dart';

final class ClinicasTheme {
  static const orangeColor = Color(0xFFFFAE45);
  static const lightOrange = Color(0xFFFFEFE9);
  static const blueColor = Color(0xFF01bdd6);
  static const lightGrey = Color(0xFFE5E5D1);

  static final _inputPadrao = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: lightOrange),
  );

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: lightOrange),
    fontFamily: 'Montserrat',
    scaffoldBackgroundColor: lightOrange,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightOrange,
      labelStyle: const TextStyle(
        color: orangeColor,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
      floatingLabelStyle: const TextStyle(
        color: blueColor,
        fontWeight: FontWeight.w600,
      ),
      enabledBorder: _inputPadrao,
      focusedBorder: _inputPadrao,
      errorBorder: _inputPadrao.copyWith(
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          fontFamily: 'Montserrat',
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData();

  static const titleStyle = TextStyle(
    color: blueColor,
    fontSize: 34,
    fontWeight: FontWeight.w900,
  );

  static const titleSmallStyle = TextStyle(
    color: blueColor,
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );

  static const subtitleStyle = TextStyle(
    color: blueColor,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
}
