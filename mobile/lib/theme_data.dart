import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    // headline1: TextStyle(
    //   fontFamily: 'Cursive',
    //   fontSize: 32,
    //   fontWeight: FontWeight.bold,
    //   color: Colors.black,
    // ),
    // bodyText1: TextStyle(
    //   fontFamily: 'Serif',
    //   fontSize: 18,
    //   color: Colors.black87,
    // ),
    // bodyText2: TextStyle(
    //   fontFamily: 'Serif',
    //   fontSize: 16,
    //   color: Colors.black54,
    // ),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.green
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black, width: 2),
    ),
    hintStyle: const TextStyle(color: Colors.black38),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        fontFamily: 'Serif',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      // minimumSize: const Size(100, 40),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
);