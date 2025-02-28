import 'package:budget_wise/src/configs/start_up.dart';
import 'package:flutter/material.dart';

import 'src/budget_wise_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await startUpConfigs();
  runApp(const BudgetWiseApp());
}
