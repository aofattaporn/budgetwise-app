import 'package:flutter/material.dart';

class TextValue {
  final String? message;
  final TextStyle? style;

  TextValue({this.style, this.message});

  TextValue withText(String message) {
    return TextValue(
      message: message,
      style: style,
    );
  }

// ================== style ==================

// ------------------ Font 12 ------------------
  TextValue getFont12Black() {
    return TextValue(
      message: message!,
      style: const TextStyle(fontSize: 12, color: Colors.black),
    );
  }

// ------------------ Font 14 ------------------
  TextValue getFont14BoldBlack() {
    return TextValue(
      message: message!,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

// ------------------ Font 16 ------------------

  TextValue getFont16BoldBlack() {
    return TextValue(
      message: message!,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  TextValue getFont16Black() {
    return TextValue(
      message: message!,
      style: const TextStyle(fontSize: 16, color: Colors.black),
    );
  }

  TextValue getFont16BoldGrey() {
    return TextValue(
      message: message!,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
    );
  }

  // ------------------ Font 12 ------------------
  TextValue getFont12BoldGrey() {
    return TextValue(
      message: message!,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
    );
  }

  TextValue getFont12Grey() {
    return TextValue(
      message: message!,
      style: const TextStyle(fontSize: 12, color: Colors.grey),
    );
  }

  // ------------------ Font 14 ------------------
  TextValue getFont14BoldGrey() {
    return TextValue(
      message: message!,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
    );
  }

  TextValue getFont14Grey() {
    return TextValue(
      message: message!,
      style: const TextStyle(fontSize: 14, color: Colors.grey),
    );
  }

  // ------------------ Font 16 ------------------
  TextValue getFont16Grey() {
    return TextValue(
      message: message!,
      style: const TextStyle(fontSize: 16, color: Colors.grey),
    );
  }

  // ------------------ Font 24 ------------------
  TextValue getFont24BoldBlack() {
    return TextValue(
      message: message!,
      style: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  TextValue getFont24Black() {
    return TextValue(
      message: message!,
      style: const TextStyle(fontSize: 24, color: Colors.black),
    );
  }

  TextValue getFont24BoldGrey() {
    return TextValue(
      message: message!,
      style: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
    );
  }

  TextValue getFont24Grey() {
    return TextValue(
      message: message!,
      style: const TextStyle(fontSize: 24, color: Colors.grey),
    );
  }

// ================== BUILD ==================

  Text build() {
    return Text(
      message!,
      style: style ?? const TextStyle(),
    );
  }
}
