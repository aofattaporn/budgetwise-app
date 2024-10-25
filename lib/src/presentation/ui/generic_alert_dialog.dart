import 'package:flutter/cupertino.dart';

class AlertDialogUtils {
  /// Displays a generic alert dialog.
  ///
  /// This method shows an alert dialog with the specified parameters.
  ///
  /// Parameters:
  /// - `title`: The title of the alert dialog.
  /// - `content`: The content of the alert dialog.
  /// - `confirmButtonText`: The text for the confirm button.
  /// - `cancelButtonText`: The text for the cancel button.
  /// - `onConfirm`: The callback function to be executed when the confirm button is pressed.
  /// - `onCancel`: The callback function to be executed when the cancel button is pressed.
  ///
  /// Example usage:
  /// ```dart
  /// showAlertDialog(
  ///   title: 'Alert',
  ///   content: 'This is an alert message.',
  ///   confirmButtonText: 'OK',
  ///   cancelButtonText: 'Cancel',
  ///   onConfirm: () {
  ///     // Handle confirm action
  ///   },
  ///   onCancel: () {
  ///     // Handle cancel action
  ///   },
  /// );
  /// ```
  static void showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Yes',
    String cancelText = 'No',
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              if (onCancel != null) onCancel();
            },
            child: Text(cancelText),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}
