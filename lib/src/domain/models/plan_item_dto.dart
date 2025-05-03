class PlanItemDto {
  final int planId;
  final String title;
  final double planAmount;
  final String category;
  final String iconName;

  PlanItemDto(
      {required this.planId,
      required this.title,
      required this.planAmount,
      required this.category,
      required this.iconName});
}
