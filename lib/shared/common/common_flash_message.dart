import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:flutter/material.dart';

class CommonFlashMessage {
  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Color? textColor,
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
    FlashMessageType type = FlashMessageType.error,
  }) {
    final theme = Theme.of(context);
    // Set default colors based on type
    Color defaultBg;
    Color defaultText;
    switch (type) {
      case FlashMessageType.success:
        defaultBg = AppColors.success;
        defaultText = AppColors.background;
        break;
      case FlashMessageType.warning:
        defaultBg = theme.colorScheme.tertiary;
        defaultText = theme.colorScheme.onTertiary;
        break;
      case FlashMessageType.info:
        defaultBg = theme.colorScheme.primaryContainer;
        defaultText = theme.colorScheme.onPrimaryContainer;
        break;
      case FlashMessageType.error:
        defaultBg = theme.colorScheme.error;
        defaultText = theme.colorScheme.onError;
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: textColor ?? defaultText,
          ),
        ),
        backgroundColor: backgroundColor ?? defaultBg,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}

enum FlashMessageType {
  error,
  success,
  warning,
  info,
}
