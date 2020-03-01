import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData = ThemeData(
  primarySwatch: Colors.indigo,
  primaryColor: Colors.indigoAccent[400],
  accentColor: Colors.indigoAccent,
  appBarTheme: AppBarTheme(
    color: Colors.grey[50],
    elevation: 0.0,
    iconTheme: IconThemeData(
        color: Colors.grey[900]
    ),
    textTheme: TextTheme(
      title: GoogleFonts.rubik(
          fontWeight: FontWeight.w800,
          fontSize: 20.0,
          color: Colors.black
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: Colors.indigoAccent[400]
  ),
  textTheme: TextTheme(
    title: GoogleFonts.rubik(
        fontWeight: FontWeight.w800
    ),
    body2: GoogleFonts.montserrat(),
    body1: GoogleFonts.montserrat(),
    button: GoogleFonts.rubik(
        fontWeight: FontWeight.w800
    ),
  ),
);