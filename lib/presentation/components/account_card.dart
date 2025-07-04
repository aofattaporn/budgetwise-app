import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String name;
  final double currentBalance;
  final Color color;
  final VoidCallback onOptionsTap;
  final String? subtitle;

  const AccountCard({
    super.key,
    required this.name,
    required this.currentBalance,
    required this.color,
    required this.onOptionsTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: color.withOpacity(0.18),
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: color,
          child: const Icon(Icons.account_balance_wallet,
              color: Colors.white, size: 24),
        ),
        title: Text(
          name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black54,
                    ),
              )
            : null,
        trailing: Row(
          spacing: 14,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              currentBalance.toStringAsFixed(2),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              '฿',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
