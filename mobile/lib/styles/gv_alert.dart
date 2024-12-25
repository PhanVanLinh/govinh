import 'package:flutter/material.dart';

class GVAlert extends StatelessWidget {
  final String message;
  final GVAlertType type;
  final bool isDismissible;
  final VoidCallback? onDismiss;
  final TextStyle? textStyle;

  GVAlert({
    required this.message,
    this.type = GVAlertType.info,
    this.isDismissible = false,
    this.onDismiss,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(type);
    final icon = _getIcon(type);

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: colors['background'],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colors['border']!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: colors['icon'], size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              message,
              style: textStyle ??
                  TextStyle(
                    color: colors['text'],
                    fontSize: 16.0,
                  ),
            ),
          ),
          if (isDismissible)
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, color: colors['icon']),
            ),
        ],
      ),
    );
  }

  Map<String, Color?> _getColors(GVAlertType type) {
    switch (type) {
      case GVAlertType.success:
        return {
          'background': Colors.green[100],
          'border': Colors.green[400],
          'text': Colors.green[900],
          'icon': Colors.green[700],
        };
      case GVAlertType.error:
        return {
          'background': Colors.red[100],
          'border': Colors.red[400],
          'text': Colors.red[900],
          'icon': Colors.red[700],
        };
      case GVAlertType.warning:
        return {
          'background': Colors.yellow[100],
          'border': Colors.yellow[400],
          'text': Colors.yellow[900],
          'icon': Colors.yellow[700],
        };
      case GVAlertType.info:
      default:
        return {
          'background': Colors.blue[100],
          'border': Colors.blue[400],
          'text': Colors.blue[900],
          'icon': Colors.blue[700],
        };
    }
  }

  IconData _getIcon(GVAlertType type) {
    switch (type) {
      case GVAlertType.success:
        return Icons.check_circle;
      case GVAlertType.error:
        return Icons.error;
      case GVAlertType.warning:
        return Icons.warning;
      case GVAlertType.info:
      default:
        return Icons.info;
    }
  }
}

enum GVAlertType {
  success,
  error,
  warning,
  info,
}
