import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color offWhite = Color(0xffFAF9F6);
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class ThemesApp {
  static final light = ThemeData(
    primaryColor: bluishClr,
    backgroundColor: offWhite,
    drawerTheme: DrawerThemeData(
      backgroundColor: offWhite,
      width: Get.width/2,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: bluishClr,
    ),
    shadowColor: darkHeaderClr,
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0,
    ),
    textTheme: TextTheme(
      headline6: GoogleFonts.roboto(),
      bodyText1: GoogleFonts.roboto(),
      bodyText2: GoogleFonts.roboto(),
      overline: GoogleFonts.roboto(),
    ),
    iconTheme: const IconThemeData(
      color: darkGreyClr,
      // opacity: 0,
    ),
    appBarTheme: const AppBarTheme(
      color: offWhite,
      elevation: 0,
    ),
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    primaryColor: bluishClr,
    backgroundColor: darkGreyClr,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: bluishClr,
      foregroundColor: offWhite,
      elevation: 0,
    ),
    shadowColor: offWhite.withOpacity(0.4),
    iconTheme: const IconThemeData(
      color: offWhite,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: darkGreyClr,
      width: Get.width/2,
    ),
    textTheme: TextTheme(
      headline6: GoogleFonts.roboto(),
      bodyText1: GoogleFonts.roboto(),
      bodyText2: GoogleFonts.roboto(),
      overline: GoogleFonts.roboto(),
    ),
    appBarTheme: const AppBarTheme(
      color: darkGreyClr,
      elevation: 0,
    ),
    brightness: Brightness.dark,
  );
}

Color customListColor(int index) {
  List<Color> color = [
    bluishClr,
    yellowClr.withOpacity(0.8),
    pinkClr.withOpacity(0.85)
  ];
  return color[index % color.length];
}

TextStyle textAppBarTheme(BuildContext context) {
  return Theme.of(context).textTheme.headline6!.copyWith(
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? offWhite : darkHeaderClr);
}

TextStyle textTitleTheme(BuildContext context) {
  return Theme.of(context).textTheme.bodyText1!.copyWith(
      fontWeight: FontWeight.w800,
      fontSize: 18,
      color: Get.isDarkMode ? offWhite : darkGreyClr);
}

TextStyle textContentTheme(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .bodyText2!
      .copyWith(fontSize: 16, color: Get.isDarkMode ? offWhite : darkGreyClr);
}

TextStyle textOverLineTheme(BuildContext context) {
  return Theme.of(context).textTheme.overline!.copyWith(
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? offWhite : darkGreyClr);
}

TextStyle textHintTheme(BuildContext context, double fontSize) {
  return Theme.of(context).textTheme.bodyText1!.copyWith(
      fontWeight: FontWeight.w900,
      fontSize: fontSize,
      letterSpacing: 1,
      color: Get.isDarkMode
          ? offWhite.withOpacity(0.5)
          : darkHeaderClr.withOpacity(0.6));
}
