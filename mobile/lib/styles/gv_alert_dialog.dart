import 'package:flutter/material.dart';
import 'package:govinh/styles/gv_textstyle.dart';
import 'package:govinh/theme/brand_color.dart';
import 'package:lottie/lottie.dart';

enum AlertDialogType {
  register, success
}

Future<void> showCommonAlertDialog(BuildContext context,
    {required AlertDialogType type,
    required String title,
    required List<Widget> body,
    required String primaryAction,
    required VoidCallback primaryActionPressed,
    String? secondaryAction,
    VoidCallback? secondaryActionPressed}) {

  bool animateRepeat;
  String image;
  Color titleColor;
  switch(type) {
    case AlertDialogType.register:
      image = "assets/images/lottie_invitation_to_join.json";
      animateRepeat = true;
      titleColor = ThemeColors.main.info;
    case AlertDialogType.success:
      image = "assets/images/lottie_anim_success2.json";
      animateRepeat = false;
      titleColor = ThemeColors.main.success;
  }

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: Column(
          children: [
            Container(
                child: Lottie.asset(image,
                    width: 160,
                    height: 160,
                    repeat: animateRepeat,
                )),
            const SizedBox(width: 10),
            Text(title, style: GVTextStyle.semiBold18.copyWith(color: ThemeColors.main.info)),
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical:16,horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: body
          ),
        ),
        actions: <Widget>[
          secondaryAction != null
              ? TextButton(
                  child: Text(secondaryAction),
                  onPressed: () {
                    secondaryActionPressed?.call();
                  },
                )
              : const SizedBox(),
          TextButton(
            child: Text(primaryAction),
            onPressed: () {
              primaryActionPressed.call();
            },
          ),
        ],
      );
    },
  );
}
