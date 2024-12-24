import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:govinh/styles/gv_textstyle.dart';

class GVTextFormField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Nhập số điện thoại",
          contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(color: Colors.green)
          ),
        ),

        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly
        ],
        autofillHints: const [
          AutofillHints.telephoneNumber,
        ],
        textAlign: TextAlign.center,
        style: GVTextStyle.semiBold22.copyWith(letterSpacing: 2.0),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}