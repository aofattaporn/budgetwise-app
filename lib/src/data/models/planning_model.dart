class Planning {
  int planId;
  String name;
  double limit;
  int indexIcon;
  String accountName;
  DateTime createDate;
  DateTime updateDate;

  Planning(
    this.planId,
    this.name,
    this.limit,
    this.indexIcon,
    this.createDate,
    this.updateDate,
    this.accountName,
  );

  Planning.create({
    required this.planId,
    required this.name,
    required this.limit,
    required this.indexIcon,
    required this.accountName,
    required this.createDate,
    required this.updateDate,
  });

  // Convert a Map (JSON) into a Planning object
// Convert a Map (JSON) into a Planning object
  factory Planning.fromJson(Map<String, dynamic> json) {
    return Planning(
      json['planId'] != null
          ? (json['planId'] as num).toInt()
          : 0, // Default to 0 if null
      json['name'] ?? '', // Provide default empty string if null
      json['amount'] != null
          ? (json['amount'] as num).toDouble()
          : 0.0, // Default to 0.0 if null
      json['indexIcon'] != null
          ? (json['indexIcon'] as num).toInt()
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
      'planId': planId,
      'name': name,
      'limit': limit,
      'indexIcon': indexIcon,
      'accountName': accountName,
      'createDate': createDate.toIso8601String(),
      'updateDate':
          updateDate.toIso8601String(), // Consistent with the field name
    };
  }
}
