class Account {
  final int? accountId; // Corresponds to account_id
  final String accountName; // Corresponds to name
  final double balance; // Corresponds to amount
  final DateTime? createDate; // Corresponds to create_date
  final DateTime? updatePlanDate; // Corresponds to update_plan_date
  final int colorIndex; // New field

  Account({
    required this.accountId,
    required this.accountName,
    required this.balance,
    required this.createDate,
    required this.updatePlanDate,
    required this.colorIndex,
  });

  // todo hande request be for create data
  // Constructor for creating an Account object to send to the server (without accountId, createDate, etc.)
  Account.forCreation({
    required this.accountName,
    required this.balance,
    required this.colorIndex,
  })  : accountId = null,
        createDate = null,
        updatePlanDate = null;

  Map<String, dynamic> createJsonRequest() {
    return {
      'name': accountName,
      'balance': balance,
      'colorIndex': colorIndex,
    };
  }

  // Convert a Map (JSON) into an Account object.
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      accountId: json['id'],
      accountName: json['name'],
      balance: (json['balance'] as num).toDouble(),
      createDate: DateTime.parse(json['createDate']),
      updatePlanDate: DateTime.parse(json['updatePlanDate']),
      colorIndex: json['colorIndex'],
    );
  }
}
