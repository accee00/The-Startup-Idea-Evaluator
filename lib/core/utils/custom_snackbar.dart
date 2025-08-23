import 'package:ai_voting_app/core/extension%20/build_context_extension.dart';
import 'package:flutter/material.dart';

enum SnackBarType { success, error, info }

void showSnackBar(BuildContext context, String text, SnackBarType type) {
  ScaffoldMessenger.of(context).clearSnackBars();

  Color backgroundColor;
  Color textColor;
  IconData icon;

  switch (type) {
    case SnackBarType.success:
      backgroundColor = const Color(0xFF10B981);
      textColor = Colors.white;
      icon = Icons.check_circle_outline;
      break;
    case SnackBarType.error:
      backgroundColor = context.colorScheme.error;
      textColor = context.colorScheme.onError;
      icon = Icons.error_outline;
      break;
    case SnackBarType.info:
      backgroundColor = context.colorScheme.primary;
      textColor = context.colorScheme.onPrimary;
      icon = Icons.info_outline;
      break;
  }

  final snackBar = SnackBar(
    margin: const EdgeInsets.all(16),
    content: Row(
      children: [
        Icon(icon, color: textColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    duration: Duration(milliseconds: type == SnackBarType.error ? 4000 : 3000),
    action: SnackBarAction(
      label: 'Dismiss',
      textColor: textColor.withAlpha(204),
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
