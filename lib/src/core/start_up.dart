import 'package:budget_wise/src/core/di/di.dart';
import 'package:budget_wise/src/core/supabase/supabase_config.dart';
import 'package:budget_wise/src/core/constant/common_constant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> startUpConfigs() async {
  await dotenv.load(fileName: CommonConstant.envFfileType);
  await supabaseConfigs(dotenv.env);
  setupLocator();
}
