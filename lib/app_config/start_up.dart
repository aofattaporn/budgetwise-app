import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/app_config/supabase/supabase_config.dart';
import 'package:budget_wise/shared/constant/common_constant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> startUpConfigs() async {
  await dotenv.load(fileName: CommonConstant.envFfileType);
  await supabaseConfigs(dotenv.env);
  await setupLocator();
}
