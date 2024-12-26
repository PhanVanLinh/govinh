import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:govinh/feature/redeem/bloc/redeem_screen_cubit.dart';
import 'package:govinh/lt.dart';
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
  IconData? _selectedIcon;
  final double _initialRating = 0;
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: BlocConsumer<RedeemCubit, RedeemUI>(listener: (context, state) {
        final action = state.action;
        if (action is GoSuccessAction) {
          context.go("/redeem-success/${action.phoneNumber}");
        }
      }, builder: (context, ui) {
        return Scaffold(
          appBar: const GVAppBar(
            title: Lt.banhcanh,
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
                  Text(
                    Lt.earnPoints,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),

                  const GVText.hint(Lt.enterYourPhoneToReceiveReward1),
                  // Text(Lt.app, style: Theme.of(context).textTheme.headlineMedium,),
                  const Gap(8),
                  GVTextFormField(
                    hint: Lt.input_phone,
                    controller: phoneTextEditingController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Allows only numbers
                    ],
                  ),
                  const Gap(32),
                  const Text(Lt.feedbackOptional),
                  const Gap(8),
                  RatingBar.builder(
                    initialRating: _initialRating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    unratedColor: Colors.amber.withAlpha(50),
                    itemCount: 5,
                    itemSize: 48.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      _selectedIcon ?? Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                    updateOnDrag: true,
                  ),
                  const Gap(8),
                  _rating != 0
                      ? const GVTextFormField(
                          keyboardType: TextInputType.multiline,
                          // maxLines: null,
                          hint: Lt.comment,
                          minLines: 3,
                        )
                      : const SizedBox(),
                  // const GVText.hint(Lt.enterYourPhoneToReceiveReward),
                  const Gap(16),
                  if (ui.error != null) ...[GVAlert(message: ui.error ?? "")],
                  GVButton(
                    title: Lt.earnPoints,
                    isLoading: ui.isLoading,
                    onPressed: () {
                      String phoneNumber = phoneTextEditingController.text;
                      cubit.redeem(phoneNumber, widget.code ?? "");
                    },
                  ),
                  const Gap(16),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
