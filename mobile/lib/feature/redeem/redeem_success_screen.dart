import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RedeemSuccessScreen extends StatefulWidget {
  final String? id;
  const RedeemSuccessScreen({super.key, required this.id});

  @override
  State<StatefulWidget> createState() {
    return RedeemSuccessScreenState();
  }
}

class RedeemSuccessScreenState extends State<RedeemSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("widget.title12"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(20),
                child: Icon(
                  Icons.check_circle_outline,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),
              // Success Text
              Text(
                'Success!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
              SizedBox(height: 16),
              // Subtitle
              Text(
                'Your action was completed successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal.shade600,
                ),
              ),
              SizedBox(height: 32),
              // Continue Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

