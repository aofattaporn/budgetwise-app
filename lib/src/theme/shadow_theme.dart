import 'package:flutter/material.dart';

class AppShadowTheme {
  static const BoxShadow lightShadow = BoxShadow(
    color: Colors.black12,
    blurRadius: 10.0,
    offset: Offset(0, 5),
  );

  static const BoxShadow mediumShadow = BoxShadow(
    color: Colors.black26,
    blurRadius: 20.0,
    offset: Offset(0, 10),
  );

  static const BoxShadow heavyShadow = BoxShadow(
    color: Colors.black38,
    blurRadius: 30.0,
    offset: Offset(0, 15),
  );

  /// Returns a list of [BoxShadow] based on the provided [ShadowLevel].
  ///
  /// The [level] parameter determines the intensity and characteristics of the shadows.
  ///
  /// - [ShadowLevel.low]: Provides a subtle shadow.
  /// - [ShadowLevel.medium]: Provides a moderate shadow.
  /// - [ShadowLevel.high]: Provides a prominent shadow.
  ///
  /// Example usage:
  /// ```dart
  /// List<BoxShadow> shadows = ShadowTheme.getShadows(ShadowLevel.medium);
  /// ```
  static List<BoxShadow> getShadows(ShadowLevel level) {
    switch (level) {
      case ShadowLevel.light:
        return [lightShadow];
      case ShadowLevel.medium:
        return [mediumShadow];
      case ShadowLevel.heavy:
        return [heavyShadow];
      default:
        return [lightShadow];
    }
  }
}

enum ShadowLevel {
  light,
  medium,
  heavy,
}
