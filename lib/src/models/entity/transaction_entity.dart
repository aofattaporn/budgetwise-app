class TransactionEntity {
  int? id; // Corresponds to transaction ID
  String name; // Name of the transaction
  double amount; // Transaction amount
  String operation; // Operation type (e.g., credit or debit)
  DateTime? createDate; // Date the transaction was created
  DateTime? updateDate; // Date the transaction was last updated
  String? planName; // Associated plan name
  String? accountName; // Associated account name
  int? indexIcon; // Icon index for UI representation

  int? planId; // Plan ID
  int? accountId; // Account ID

  // Constructor with named parameters for better clarity
  TransactionEntity({
    this.id,
    required this.name,
    required this.amount,
    required this.operation,
    required this.createDate,
    required this.updateDate,
    required this.planName,
    required this.accountName,
    required this.indexIcon,
    this.planId,
    this.accountId,
  });

  TransactionEntity.create({
    required this.name,
    required this.amount,
    required this.operation,
    required this.planId,
    required this.accountId,
  });

  // Factory constructor to create a Transaction object from a JSON map
  factory TransactionEntity.fromJson(Map<String, dynamic> json) {
    return TransactionEntity(
      id: json['transactionId'] ?? 0,
      name: json['name'],
      amount: (json['amount'] as num).toDouble(),
      operation: json['operation'],
      createDate: DateTime.parse(json['createDate']),
      updateDate: DateTime.parse(json['updateDate']),
      planName: json['planName'],
      accountName: json['accountName'],
      indexIcon: (json['iconIndex'] as num).toInt(),
      planId: json['planId'],
      accountId: json['accountId'],
    );
  }

  // Convert the Transaction object to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'operation': operation,
      'planId': planId,
      'accountId': accountId,
    };
  }
}
