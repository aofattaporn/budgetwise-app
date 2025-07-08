import 'package:budget_wise/domain/entities/transaction_entity.dart';

class TransactionDto {
  final String? id;
  final String userId;
  final String? planItemId;
  final String accountId;
  final double amount;
  final String type;
  final String name;
  final String? note;
  final DateTime transactionDate;
  final String? createdAt;
  final String? updatedAt;

  TransactionDto({
    this.id,
    required this.userId,
    this.planItemId,
    required this.accountId,
    required this.amount,
    required this.type,
    required this.name,
    this.note,
    required this.transactionDate,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionDto.fromJson(Map<String, dynamic> json) {
    return TransactionDto(
      id: json['id'],
      userId: json['user_id'],
      planItemId: json['plan_item_id'],
      accountId: json['account_id'],
      amount: (json['amount'] as num).toDouble(),
      type: json['type'],
      name: json['name'],
      note: json['note'],
      transactionDate: DateTime.parse(json['transaction_date']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

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
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  Map<String, dynamic> toInsertJson() => {
        'user_id': userId,
        'plan_item_id': planItemId,
        'account_id': accountId,
        'amount': amount,
        'type': type,
        'name': name,
        'note': note,
        'transaction_date': transactionDate.toIso8601String(),
      };

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id ?? '',
      userId: userId,
      planItemId: planItemId,
      accountId: accountId,
      amount: amount,
      type: type,
      name: name,
      note: note,
      transactionDate: transactionDate,
      createdAt:
          createdAt != null ? DateTime.parse(createdAt!) : DateTime.now(),
      updatedAt:
          updatedAt != null ? DateTime.parse(updatedAt!) : DateTime.now(),
    );
  }

  static TransactionDto fromEntity(TransactionEntity entity) {
    return TransactionDto(
      id: entity.id,
      userId: entity.userId,
      planItemId: entity.planItemId,
      accountId: entity.accountId,
      amount: entity.amount,
      type: entity.type,
      name: entity.name,
      note: entity.note,
      transactionDate: entity.transactionDate,
      createdAt: entity.createdAt.toIso8601String(),
      updatedAt: entity.updatedAt.toIso8601String(),
    );
  }

  map(Function(dynamic e) param0) {}
}
