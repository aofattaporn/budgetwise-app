class CommonConstant {
  static const String envFfileType = ".env";
  static const int percentage = 100;

  static const String accept_lang_th = "th";
  static const String accept_lang_en = "en";

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

  static const String deleteDescLabel = "You are going to delete this plan";
}

enum CommonState { idle, loading, success, error }
