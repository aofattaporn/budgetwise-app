import 'package:flutter/material.dart';

import 'src/app.dart';

void main() {
  runApp(const MyApp());
  // ignore: deprecated_member_use
  // BlocOverrides.runZoned(
  //   () => runApp(
  //     const MyApp(),
  //   ),
  //   blocObserver: AppBlocObserver(),
  // );
}
