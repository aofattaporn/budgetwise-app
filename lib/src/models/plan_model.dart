class PlanModel {
  int? planId;
  String name;
  String type;
  double usage;
  double limit;
  int indexIcon;
  int? accountId;
  String? accountName;
  DateTime? createDate;
  DateTime? updateDate;
  DateTime? month;

  PlanModel(
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

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
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
}
