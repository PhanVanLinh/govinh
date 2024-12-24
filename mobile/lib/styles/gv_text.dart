import 'package:flutter/material.dart';
import 'package:govinh/styles/gv_textstyle.dart';

enum GVTextType { hint, normal }

class GVText extends StatelessWidget {
  final GVTextType type;
  final String data;

  const GVText({super.key, required this.data}) : type = GVTextType.normal;

  const GVText.hint(this.data, {super.key}) : type = GVTextType.hint;

  @override
  Widget build(BuildContext context) {
    if (type == GVTextType.hint) {
      return Text(data, style: GVTextStyle.regular14.copyWith(color: Colors.grey));
    }
    return Text(data, style: GVTextStyle.regular14.copyWith(color: Colors.grey));
  }
}
