import 'package:flutter/material.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';

class OptionPlanItemSheet extends StatelessWidget {
  final Function(BuildContext) onEdit;
  final Function(BuildContext) onDelete;

  const OptionPlanItemSheet({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOptionTile(
              icon: Icons.edit,
              label: 'Edit',
              onTap: () {
                onEdit(context);
              },
            ),
            const Divider(),
            _buildOptionTile(
              icon: Icons.delete_outline,
              label: 'Delete',
              iconColor: AppColors.error,
              textColor: AppColors.error,
              onTap: () {
                onDelete(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = AppColors.primaryDark,
    Color textColor = AppColors.primaryDark,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(label, style: TextStyle(color: textColor)),
      onTap: onTap,
    );
  }
}
