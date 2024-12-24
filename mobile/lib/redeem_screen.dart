import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:govinh/lt.dart';
import 'package:govinh/styles/gv_button.dart';
import 'package:govinh/styles/gv_text.dart';
import 'package:govinh/styles/gv_textformfield.dart';

class RedeemScreen extends StatefulWidget {
  final String? id;
  const RedeemScreen({super.key, required this.id});

  @override
  State<StatefulWidget> createState() {
    return RedeemScreenState();
  }
}

class RedeemScreenState extends State<RedeemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(Lt.app),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              border: Border.all(
                color: Colors.black, // Border color
                width: 1,           // Border width
              ),
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(Lt.reward, style: Theme.of(context).textTheme.headlineLarge,),
                // Text(Lt.app, style: Theme.of(context).textTheme.headlineMedium,),
                const Gap(32),
                // MyCustomForm(),
                // const Gap(20),
                GVTextFormField(),
                const Gap(32),
                GVButton(title: Lt.redeem, onPressed: () {

                },),
                const Gap(16),
                GVText.hint(Lt.enterYourPhoneToReceiveReward)
              ],
            ),
          )
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GVTextFormField(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: GVButton(title: "title", onPressed: () {

            })
          ),
        ],
      ),
    );
  }
}