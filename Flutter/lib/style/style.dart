import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Chosen by Bill dalao
const bgcolor = Color.fromRGBO(255, 247, 219, 1);
const medgreen = Color.fromRGBO(134, 177, 91, 1);
const dark = Color.fromRGBO(62, 62, 62, 1);
const darkgreen = Color.fromRGBO(74, 129, 18, 1);
const lightgreen = Color.fromRGBO(210, 224, 196, 1);

// header => headlineMedium
// submenuHeader => headlineSmall
// whiteSubmenuHeader => headlineSmall (colours can be overwritten right?)
// hintText => labelMedium
// bodyText => bodyMedium

ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromRGBO(134, 177, 9, 1),
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
        headlineMedium:
            TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: dark),
        headlineSmall: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 20, color: darkgreen),
        labelMedium: TextStyle(
            fontWeight: FontWeight.w400, color: Colors.black26, fontSize: 14),
        bodyMedium:
            TextStyle(fontWeight: FontWeight.w400, color: dark, fontSize: 16),
        bodySmall: TextStyle(color: Colors.white, fontSize: 13)),
    useMaterial3: true,
    scaffoldBackgroundColor: bgcolor,
    fontFamily: GoogleFonts.jost().fontFamily);
