import 'package:flutter/material.dart';

/// {@template app_shadow}
/// Shadow class contains all shadows used in the app.
/// {@endtemplate}
class AppShadow {
  AppShadow._();

  /// Extra small shadow.
  static const xs = [
    BoxShadow(
      blurRadius: 2,
      offset: Offset(0, 1),
      color: Color.fromRGBO(16, 24, 40, 0.05),
    ),
  ];

  /// Small shadow.
  static const sm = [
    BoxShadow(color: Color(0x0F101828), blurRadius: 2, offset: Offset(0, 1)),
    BoxShadow(color: Color(0x19101828), blurRadius: 3, offset: Offset(0, 1)),
  ];

  /// Medium shadow.
  static const md = [
    BoxShadow(color: Color(0x0F101828), blurRadius: 4, offset: Offset(0, 2)),
    BoxShadow(color: Color(0x19101828), blurRadius: 6, offset: Offset(0, 2)),
  ];

  /// Large shadow.
  static const lg = [
    BoxShadow(color: Color(0x0D101828), blurRadius: 8, offset: Offset(0, 4)),
    BoxShadow(color: Color(0x19101828), blurRadius: 10, offset: Offset(0, 4)),
  ];

  /// Extra large shadow.
  static const xl = [
    BoxShadow(color: Color(0x0D101828), blurRadius: 12, offset: Offset(0, 6)),
    BoxShadow(color: Color(0x19101828), blurRadius: 16, offset: Offset(0, 6)),
  ];

  /// Extra extra large shadow.
  static const xxl = [
    BoxShadow(color: Color(0x0D101828), blurRadius: 16, offset: Offset(0, 8)),
    BoxShadow(color: Color(0x19101828), blurRadius: 24, offset: Offset(0, 8)),
  ];

  /// Maximum shadow.
  static const max = [
    BoxShadow(color: Color(0x0D101828), blurRadius: 24, offset: Offset(0, 12)),
    BoxShadow(color: Color(0x19101828), blurRadius: 32, offset: Offset(0, 12)),
  ];
}
