import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData baseTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,


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

ThemeData theme = baseTheme.copyWith(
  textTheme: GoogleFonts.notoSansTextTheme(baseTheme.textTheme),
);