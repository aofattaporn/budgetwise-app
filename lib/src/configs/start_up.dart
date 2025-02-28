import 'package:budget_wise/src/configs/supabase/supabase_config.dart';
import 'package:budget_wise/src/constant/common_constant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> startUpConfigs() async {
  await dotenv.load(fileName: CommonConstant.envFfileType);
  await supabaseConfigs(dotenv.env);
}
