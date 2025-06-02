class BusinessConstant {
  static const String titleBudgetWise = "Budget Wise";
  static const String bathUnit = "B";

  static const String tranfersType = "Transfer";
  static const String savingType = "Saving";
  static const String unplannedType = "Unplanned";

  static const String successMessage = "You will be contacted by us very soon.";

  // API Constants
  static const String contextPath = "/api";

  static const String otherPlanCategory = "OTHER";
  static const String incomePlanCategory = "INCOME";
  static const String savingPlanCategory = "SAVING";
  static const String expensePlanCategory = "EXPENSE";

  static const String savingPlanSegment = "Saving";
  static const String expensePlanSegment = "Expense";
  static const Map<int, String> segmentOptions = <int, String>{
    0: expensePlanSegment,
    1: savingPlanSegment,
  };
}
