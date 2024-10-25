import 'package:budget_wise/src/AppBlocObserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
