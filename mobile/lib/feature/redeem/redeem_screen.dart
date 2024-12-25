import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:govinh/feature/redeem/redeem_screen_cubit.dart';
import 'package:govinh/lt.dart';
import 'package:govinh/main.dart';
import 'package:govinh/styles/gv_alert.dart';
import 'package:govinh/styles/gv_appbar.dart';
import 'package:govinh/styles/gv_button.dart';
import 'package:govinh/styles/gv_text.dart';
import 'package:govinh/styles/gv_text_form_field.dart';

class RedeemScreen extends StatefulWidget {
  final String? code;
  const RedeemScreen({super.key, required this.code});

  @override
  State<StatefulWidget> createState() {
    return RedeemScreenState();
  }
}

class RedeemScreenState extends State<RedeemScreen> {
  RedeemCubit cubit = RedeemCubit();
  TextEditingController phoneTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: BlocConsumer<RedeemCubit, RedeemUI>(
        listener: (context, state) {
          final action = state.action;
          if(action is GoSuccessAction) {
            context.go("/redeem/success/${action.phoneNumber}");
          }
        },
        builder: (context, ui) {
          return Scaffold(
            appBar: const GVAppBar(
              title: Lt.app,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(Lt.earnPoints, style: Theme
                        .of(context)
                        .textTheme
                        .headlineLarge,),
                    // Text(Lt.app, style: Theme.of(context).textTheme.headlineMedium,),

                    const Gap(32),
                    GVTextFormField(
                      // labelText: "A",
                      controller: phoneTextEditingController,
                    ),
                    const GVText.hint(Lt.enterYourPhoneToReceiveReward),
                    const Gap(16),
                    if(ui.error != null) ...[
                      GVAlert(message: ui.error ?? "")
                    ],
                    GVButton(title: Lt.earnPoints,
                      isLoading: ui.isLoading,
                      onPressed: () {
                        String phoneNumber = phoneTextEditingController.text;
                        cubit.redeem(phoneNumber, widget.code ?? "");
                      },),
                    const Gap(16),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
