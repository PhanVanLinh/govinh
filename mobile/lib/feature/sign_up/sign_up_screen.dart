import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:govinh/feature/sign_up/bloc/sign_up_cubit.dart';
import 'package:govinh/lt.dart';
import 'package:govinh/styles/gv_alert_dialog.dart';
import 'package:govinh/styles/gv_appbar.dart';
import 'package:govinh/styles/gv_button.dart';
import 'package:govinh/styles/gv_snack_bar.dart';
import 'package:govinh/styles/gv_text_form_field.dart';
import 'package:sprintf/sprintf.dart';

class SignUpScreen extends StatefulWidget {
  final String phone;

  const SignUpScreen({
    super.key,
    required this.phone,
  });

  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  SignUpCubit signUpCubit = SignUpCubit();
  late TextEditingController phoneController = TextEditingController(text: widget.phone);
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => signUpCubit,
        child: BlocConsumer<SignUpCubit, SignUpUI>(listener: (context, state) {
          final action = state.action;
          if (action is SignUpSuccessAction) {
            showSignUpSuccess(action.phoneNumber);
          } else if(state.error != null) {
            showSnackBar(context, message: state.error?.toString() ?? "");
          }
        }, builder: (context, ui) {
          return Scaffold(
            appBar: const GVAppBar(
              title: Lt.app,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GVTextFormField(
                      label: Lt.input_phone,
                      hint: Lt.inputPhoneHint,
                      controller: phoneController),
                  const Gap(16),
                  GVTextFormField(
                      label: Lt.inputName,
                      hint: Lt.inputNameHint,
                      controller: nameController),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(16),
              child: GVButton(
                title: Lt.signup,
                isLoading: ui.isLoading,
                onPressed: () {
                  signUpCubit.signUp(phoneController.text, nameController.text);
                },
              ),
            ),
          );
        }));
  }

  void showSignUpSuccess(String phoneNumber) async {
    showCommonAlertDialog(context,
        type: AlertDialogType.success,
        title: Lt.signupSuccess,
        body: [HtmlWidget(sprintf(Lt.signupSuccessReturn, [phoneNumber]))],
        primaryAction: Lt.redeem, primaryActionPressed:() {
        // close current screen
        Navigator.of(context).pop();
        Navigator.of(context).pop();
    });
  }
}
