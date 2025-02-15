import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
    displaySmall: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineSmall: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black),
    bodyLarge: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black),
    bodyMedium: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
    titleMedium: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black54),
    titleSmall: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black54),
    bodySmall: TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black54),
    labelLarge: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
    labelSmall: TextStyle(
        fontSize: 10.0, fontWeight: FontWeight.normal, color: Colors.black54),
  );

  static TextTheme darkTextTheme = const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineSmall: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white),
    bodyMedium: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
    titleMedium: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white70),
    titleSmall: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white70),
    bodySmall: TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white70),
    labelLarge: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
    labelSmall: TextStyle(
        fontSize: 10.0, fontWeight: FontWeight.normal, color: Colors.white70),
  );
}
