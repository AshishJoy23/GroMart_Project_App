import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gromart_project/view/config/colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kSecondaryColor,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
    textTheme: textTheme(),
  );
}

TextTheme textTheme() {
  return TextTheme(
    headlineLarge: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    ),
    headlineMedium: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    headlineSmall: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    titleLarge: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    titleMedium: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    bodyLarge: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
    bodyMedium: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),
    bodySmall: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
