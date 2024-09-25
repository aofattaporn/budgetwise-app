class Planning {
  int? planId;
  String name;
  double? usage;
  double limit;
  int indexIcon;
  int? accountId;
  String? accountName;
  DateTime? createDate;
  DateTime? updateDate;

  Planning(
    this.planId,
    this.name,
    this.usage,
    this.limit,
    this.indexIcon,
    this.createDate,
    this.updateDate,
    this.accountName,
  );

  Planning.Details({
    required this.planId,
    required this.name,
    required this.usage,
    required this.limit,
    required this.indexIcon,
    required this.accountName,
    required this.createDate,
    required this.updateDate,
  });

  Planning.create({
    required this.name,
    required this.limit,
    required this.indexIcon,
    required this.accountId,
  });

  // Convert a Map (JSON) into a Planning object
// Convert a Map (JSON) into a Planning object
  factory Planning.fromJson(Map<String, dynamic> json) {
    return Planning(
      json['planId'] != null
          ? (json['planId'] as num).toInt()
          : 0, // Default to 0 if null
      json['name'] ?? '', // Provide default empty string if null
      json['usage'] != null
          ? (json['usage'] as num).toDouble()
          : 0.0, // Default to 0.0 if null
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
    );
  }

  // Convert the Planning object to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': limit,
      'iconIndex': indexIcon,
      'accountId': accountId,
    };
  }
}
