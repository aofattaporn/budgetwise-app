import 'package:budget_wise/src/constant/common_constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> supabaseConfigs(Map<String, String> env) async {
  await Supabase.initialize(
    url: env[CommonConstant.supabaseUrlKey] ?? '',
    anonKey: env[CommonConstant.supabaseAnonKey] ?? '',
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
    storageOptions: const StorageClientOptions(
      retryAttempts: 10,
    ),
  );
}
