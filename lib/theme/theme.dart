import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:holool_ecommerce/theme/color.dart';

final ThemeData themeData = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  visualDensity: VisualDensity.standard,
  useMaterial3: true,

  //======= Text Theme =======/
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.overpass(color: Colors.white),
    bodyMedium: GoogleFonts.overpass(color: Colors.white),
    bodySmall: GoogleFonts.overpass(color: Colors.white),
    titleLarge: GoogleFonts.overpass(color: Colors.white),
    titleMedium: GoogleFonts.overpass(color: Colors.white),
    titleSmall: GoogleFonts.overpass(color: Colors.white),
    displayLarge: GoogleFonts.overpass(color: Colors.white),
    displayMedium: GoogleFonts.overpass(color: Colors.white),
    displaySmall: GoogleFonts.overpass(color: Colors.white),
    headlineLarge: GoogleFonts.overpass(color: Colors.white),
    headlineMedium: GoogleFonts.overpass(color: Colors.white),
    headlineSmall: GoogleFonts.overpass(color: Colors.white),
    labelLarge: GoogleFonts.overpass(color: Colors.white),
    labelMedium: GoogleFonts.overpass(color: Colors.white),
    labelSmall: GoogleFonts.overpass(color: Colors.white),
  ),

  //==========Button Theme ========///
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),

  //======Icon Theme ========//
  iconTheme: const IconThemeData(
    color: AppColors.gray,
    size: 30,
  ),

  //========= List tile Theme =======//
  listTileTheme: const ListTileThemeData(
    iconColor: AppColors.gray,
  ),

  //========= text field Theme =======//
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.overpass(color: Colors.grey.withOpacity(0.5)),
    labelStyle: GoogleFonts.overpass(color: AppColors.gray),
    // focusColor: AppColors.dark,
    // hoverColor: AppColors.dark,
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: AppColors.borderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: AppColors.borderColor),
    ),
  ),

  //===== App Bar Theme======//
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.overpass(
      fontSize: 20,
      color: AppColors.textLightColor,
    ),
    backgroundColor: AppColors.primaryColor,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),

  //======= Tab Bar Theme =======//
  tabBarTheme: TabBarTheme(
    labelColor: AppColors.textLightColor,
    unselectedLabelColor: AppColors.secondaryColor,
    labelStyle: GoogleFonts.overpass(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: GoogleFonts.overpass(
      color: AppColors.secondaryColor,
    ),
    indicator: BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(5),
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
  ),

  //======= Elevated Button Theme =======//
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: GoogleFonts.overpass(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  //======= Card Theme =======//
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    margin: const EdgeInsets.all(8.0),
  ),

  //======= Popup Menu Theme =======//
  popupMenuTheme: PopupMenuThemeData(
    color: AppColors.primaryColor,
    textStyle: GoogleFonts.overpass(color: Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  //======= Selection Text Theme =======//
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.primaryColor,
    selectionColor: AppColors.primaryColor.withOpacity(0.5),
    selectionHandleColor: AppColors.primaryColor,
  ),

  //======= Progrss Indicator Theme =======//
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.primaryColor,
  ),

  //Indicator Theme
  indicatorColor: AppColors.primaryColor,
);
