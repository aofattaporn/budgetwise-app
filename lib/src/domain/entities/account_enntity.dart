class AccountEntity {
  final String id;
  final String userId;
  final String name;
  final double initialBalance;
  final double currentBalance;
  final String? color;
  final DateTime createdAt;
  final DateTime updatedAt;

  AccountEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.initialBalance,
    required this.currentBalance,
    this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AccountEntity.fromJson(Map<String, dynamic> json) => AccountEntity(
        id: json['id'],
        userId: json['user_id'],
        name: json['name'],
        initialBalance: (json['initial_balance'] as num).toDouble(),
        currentBalance: (json['current_balance'] as num).toDouble(),
        color: json['color'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'initial_balance': initialBalance,
        'current_balance': currentBalance,
        'color': color,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
