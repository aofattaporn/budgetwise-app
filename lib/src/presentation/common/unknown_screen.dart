import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  static const String kTitle = 'Screen Not Found';
  // static const String _kBody =
  //     'The screen you are looking for might have been moved.';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.help_outline, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              // Text(
              //   kTitle,
              //   style: TextStyles.size22w600,
              // ),
              // SizedBox(height: 8),
              // Text(
              //   _kBody,
              //   textAlign: TextAlign.center,
              //   style: TextStyles.size12w600,
              // ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
