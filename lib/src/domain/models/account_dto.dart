import 'package:budget_wise/src/domain/entities/account_enntity.dart';
import 'package:budget_wise/src/presentation/utils/user_util.dart';

class AccountDto {
  final String? id;
  final String userId;
  final String name;
  final double initialBalance;
  final double currentBalance;
  final String? color;
  final String? createdAt;
  final String? updatedAt;

  AccountDto({
    this.id,
    required this.userId,
    required this.name,
    required this.initialBalance,
    required this.currentBalance,
    this.color,
    this.createdAt,
    this.updatedAt,
  });

  factory AccountDto.fromJson(Map<String, dynamic> json) {
    return AccountDto(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      initialBalance: (json['initial_balance'] as num).toDouble(),
      currentBalance: (json['current_balance'] as num).toDouble(),
      color: json['color'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'initial_balance': initialBalance,
        'current_balance': currentBalance,
        'color': color,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  Map<String, dynamic> toInsertJson() => {
        'user_id': UserUtil.aofUid(),
        'name': name,
        'initial_balance': initialBalance,
        'current_balance': currentBalance,
        'color': color,
      };

  Map<String, dynamic> toUpdateJson() => {
        'user_id': userId,
        'name': name,
        'initial_balance': initialBalance,
        'current_balance': currentBalance,
        'color': color,
      };

  AccountEntity toEntity() {
    return AccountEntity(
      id: id!,
      userId: userId,
      name: name,
      initialBalance: initialBalance,
      currentBalance: currentBalance,
      color: color,
      createdAt: DateTime.parse(createdAt!),
      updatedAt: DateTime.parse(updatedAt!),
    );
  }

  static AccountDto fromEntity(AccountEntity entity) {
    return AccountDto(
      id: entity.id,
      userId: entity.userId,
      name: entity.name,
      initialBalance: entity.initialBalance,
      currentBalance: entity.currentBalance,
      color: entity.color,
      createdAt: entity.createdAt.toIso8601String(),
      updatedAt: entity.updatedAt.toIso8601String(),
    );
  }
}
