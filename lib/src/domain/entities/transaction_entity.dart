class TransactionEntity {
  final String id;
  final String userId;
  final String? planItemId;
  final String accountId;
  final double amount;
  final String type;
  final String name;
  final String? note;
  final DateTime transactionDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  TransactionEntity({
    required this.id,
    required this.userId,
    this.planItemId,
    required this.accountId,
    required this.amount,
    required this.type,
    required this.name,
    this.note,
    required this.transactionDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionEntity.fromJson(Map<String, dynamic> json) =>
      TransactionEntity(
        id: json['id'],
        userId: json['user_id'],
        planItemId: json['plan_item_id'],
        accountId: json['account_id'],
        amount: (json['amount'] as num).toDouble(),
        type: json['type'],
        name: json['name'],
        note: json['note'],
        transactionDate: DateTime.parse(json['transaction_date']),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'plan_item_id': planItemId,
        'account_id': accountId,
        'amount': amount,
        'type': type,
        'name': name,
        'note': note,
        'transaction_date': transactionDate.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
