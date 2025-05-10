class SavingHistoryEntity {
  final String id;
  final String userId;
  final String planId;
  final String? accountId;
  final double amount;
  final String? note;
  final DateTime createdAt;

  SavingHistoryEntity({
    required this.id,
    required this.userId,
    required this.planId,
    this.accountId,
    required this.amount,
    this.note,
    required this.createdAt,
  });

  factory SavingHistoryEntity.fromJson(Map<String, dynamic> json) =>
      SavingHistoryEntity(
        id: json['id'],
        userId: json['user_id'],
        planId: json['plan_id'],
        accountId: json['account_id'],
        amount: (json['amount'] as num).toDouble(),
        note: json['note'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'plan_id': planId,
        'account_id': accountId,
        'amount': amount,
        'note': note,
        'created_at': createdAt.toIso8601String(),
      };
}
