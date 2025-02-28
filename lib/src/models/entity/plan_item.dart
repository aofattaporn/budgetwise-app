class PlanItem {
  int id;
  DateTime createdAt;
  int planId;
  String title;
  double usage;
  double planAmount;
  String category;

  PlanItem({
    required this.id,
    required this.createdAt,
    required this.planId,
    required this.title,
    required this.usage,
    required this.planAmount,
    required this.category,
  });

  // Factory constructor to create a PlanItem object from a Map
  factory PlanItem.fromMap(Map<String, dynamic> map) {
    return PlanItem(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      planId: map['plan_id'] as int,
      title: map['title'] as String,
      usage: (map['usage'] as num).toDouble(),
      planAmount: (map['plan_amount'] as num).toDouble(),
      category: map['category'] as String,
    );
  }

  // Method to convert a PlanItem object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'plan_id': planId,
      'title': title,
      'usage': usage,
      'plan_amount': planAmount,
      'category': category,
    };
  }
}
