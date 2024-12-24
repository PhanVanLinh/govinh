import 'package:flutter/material.dart';

class GVButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const GVButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed:onPressed,
        child:  Text(title),
      ),
    );
  }
}