import 'package:logger/logger.dart';

class CommonConstant {
  CommonConstant._();

  static const String envFfileType = ".env";
  static const int percentage = 100;

  static const String accept_lang_th = "th";
  static const String accept_lang_en = "en";

  static const String empty = "";
  static const int number_0 = 0;
  static const int number_1 = 1;

// *** Common Lib Key ***
  static const String supabaseUrlKey = "SUPABASE_URL";
  static const String supabaseAnonKey = "SUPABASE_ANONKEY";

  // *** Common Label ***
  static const String startDateLabel = "Start Date";
  static const String endDateLabel = "End Date";
  static const String enterCommonLabel = "Enter amount";
  static const String editLabel = "Edit";
  static const String cancelLabel = "Cancel";
  static const String deleteLabel = "Delete";
  static const String newItem = "New Item";
  static const String save = "Save";
  static const String update = "Update";

  static const String deleteDescLabel = "You are going to delete this plan";
  static const String msgSomethingWentWrong = "Something went wrong...";
  static const String msgPleasToTryAgain = "Please try again later.";

  static const String noItemMsg = "No Items Yet";
  static const String createFirstMsg = "Create your first item.";

  static const String loadingLabel = "Loading...";
  static const String loadingDesc = "Please wait a moment.";

  // *** Common logger ***
  static final Map<Level, String> levelEmojis = {
    Level.debug: '🐛',
    Level.info: 'ℹ️',
    Level.warning: '⚠️',
    Level.error: '❌',
    // ignore: deprecated_member_use
    Level.wtf: '💀',
  };
}

enum CommonState { idle, loading, success, error }
