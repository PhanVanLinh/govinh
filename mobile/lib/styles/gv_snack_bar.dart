import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String message, Duration duration = const Duration(seconds: 3)}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: duration,
    ),
  );
}
