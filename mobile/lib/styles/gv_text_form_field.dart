import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:govinh/styles/gv_textstyle.dart';
import 'package:govinh/styles/theme_config.dart';

class GVTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? label;
  final String? hint;
  final List<TextInputFormatter>? inputFormatters;
  final int? minLines;
  final int? maxLines;

  const GVTextFormField({
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.label,
    this.hint,
    this.inputFormatters,
    this.minLines,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label != null) ...[
          Text(label ?? "", style: Theme.of(context).textTheme.labelLarge,),
          const Gap(4),
        ],
        TextFormField(
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: const BorderSide(
                color: GVColor.outline,
                width: 2.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: const BorderSide(
                color: Colors.green,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
          ),
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          style: const TextStyle(fontSize: 16.0),
          maxLines: maxLines,
          minLines: minLines,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
        ),
      ],
    );
  }
}
