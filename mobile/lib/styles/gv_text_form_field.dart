import 'package:flutter/material.dart';

class GVTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  const GVTextFormField({
    Key? key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  _GVTextFormFieldState createState() => _GVTextFormFieldState();
}

class _GVTextFormFieldState extends State<GVTextFormField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0), // Ensure rounded corners
        border: Border.all(
          color: _isFocused ? Colors.blue : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0), // Clip the child widget to maintain the rounded corners
        child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          style: const TextStyle(fontSize: 16.0),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
            focusedBorder: InputBorder.none, // Remove default focus border.
            enabledBorder: InputBorder.none, // Remove default enabled border.
            border: InputBorder.none, // No border here, we'll handle it manually.
          ),
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          onTap: () {
            setState(() {
              _isFocused = true;
            });
          },
          onEditingComplete: () {
            setState(() {
              _isFocused = false;
            });
          },
          validator: widget.validator,
        ),
      ),
    );
  }
}
