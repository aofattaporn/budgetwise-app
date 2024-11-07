class PlanEntity {
  int? planId;
  String name;
  String? type;
  double? usage;
  double limit;
  int indexIcon;
  int? accountId;
  String? accountName;
  DateTime? createDate;
  DateTime? updateDate;
  DateTime? month;

  PlanEntity(
      this.planId,
      this.name,
      this.usage,
      this.type,
      this.limit,
      this.indexIcon,
      this.createDate,
      this.updateDate,
      this.accountName,
      this.month);

  PlanEntity.Details({
    required this.planId,
    required this.name,
    required this.usage,
    required this.limit,
    required this.indexIcon,
    required this.accountName,
    required this.createDate,
    required this.updateDate,
  });

  PlanEntity.create(
      {required this.name,
      required this.limit,
      required this.indexIcon,
      required this.accountId,
      required this.month});

  PlanEntity.update({
    required this.planId,
    required this.name,
    required this.limit,
    required this.indexIcon,
    required this.accountId,
  });

  // Convert a Map (JSON) into a Planning object
// Convert a Map (JSON) into a Planning object
  factory PlanEntity.fromJson(Map<String, dynamic> json) {
    print(json);
    return PlanEntity(
      json['planId'] != null
          ? (json['planId'] as num).toInt()
          : 0, // Default to 0 if null
      json['name'] ?? '', // Provide default empty string if null
      json['usage'] != null
          ? (json['usage'] as num).toDouble()
          : 0.0, // Default to 0.0 if null
      json['type'] ?? '', // Provide default empty string if null
      json['amount'] != null
          ? (json['amount'] as num).toDouble()
          : 0.0, // Default to 0.0 if null
      json['iconIndex'] != null
          ? (json['iconIndex'] as num).toInt()
          : 0, // Default to 0 if null
      json['createDate'] != null
          ? DateTime.parse(json['createDate'])
          : DateTime.now(), // Default to current date if null
      json['updateDate'] != null
          ? DateTime.parse(json['updateDate'])
          : DateTime.now(), // Default to current date if null
      json['accountName'] ?? '', // Provide default empty string if null
      json['month'] != null ? DateTime.parse(json['month']) : DateTime.now(),
    );
  }

  // Convert the Planning object to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': limit,
      'type': "tranfers",
      'iconIndex': indexIcon,
      'month': DateTime.utc(month!.year, month!.month).toIso8601String(),
      'accountId': accountId,
    };
  }
}
