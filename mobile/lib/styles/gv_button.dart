import 'package:flutter/material.dart';
import 'package:govinh/theme/brand_color.dart';

class GVButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final GVButtonStyle style; // Button style variant.
  final double? borderRadius;
  final double? fontSize;
  final double height;

  const GVButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.isLoading = false,
    this.style = GVButtonStyle.primary, // Default style is "primary".
    this.borderRadius = 8.0,
    this.fontSize = 16.0,
    this.height = 48.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColors = _getButtonColors(style);

    return SizedBox(
      width: double.infinity, // Full width.
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColors['background'],
          disabledBackgroundColor: Colors.grey[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.0,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              "Loading...",
              style: TextStyle(color: Colors.white),
            ),
          ],
        )
            : Text(
          title,
          style: TextStyle(
            color: buttonColors['text'],
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Method to get button colors based on style.
  Map<String, Color> _getButtonColors(GVButtonStyle style) {
    switch (style) {
      case GVButtonStyle.success:
        return {'background': Colors.green, 'text': Colors.white};
      case GVButtonStyle.warning:
        return {'background': Colors.orange, 'text': Colors.white};
      case GVButtonStyle.error:
        return {'background': Colors.red, 'text': Colors.white};
      case GVButtonStyle.info:
        return {'background': Colors.blue, 'text': Colors.white};
      case GVButtonStyle.secondary:
        return {'background': Colors.grey, 'text': Colors.white};
      case GVButtonStyle.light:
        return {'background': Colors.white, 'text': Colors.black};
      case GVButtonStyle.dark:
        return {'background': Colors.black, 'text': Colors.white};
      case GVButtonStyle.primary:
      default:
        return {'background': ThemeColors.main.primary, 'text': Colors.white};
    }
  }
}

/// Enum for button style variants.
enum GVButtonStyle {
  primary,
  success,
  warning,
  error,
  info,
  secondary,
  light,
  dark,
}
