import 'package:flutter/material.dart';

import 'colors.dart';
import 'configs.dart';

class ThisAppTheme {
  static final themeData = ThemeData(
    scaffoldBackgroundColor: ThisAppColors.bgColor,
    // Define the default font family.
    //fontFamily: 'Georgia',
    // Define the default brightness and colors.
    //brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ThisAppColors.primaryColor,
      secondary: ThisAppColors.secondaryColor,
      background: ThisAppColors.bgColor,
      //primaryVariant: ThisAppColors.primaryColor,
      //surface: ThisAppColors.bgColor,
    ),
    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
      headline1: TextStyle(color: ThisAppColors.normalTextColor),
      headline2: TextStyle(color: ThisAppColors.normalTextColor),
      headline3: TextStyle(color: ThisAppColors.normalTextColor),
      headline4: TextStyle(color: ThisAppColors.normalTextColor),
      headline5: TextStyle(color: ThisAppColors.normalTextColor),
      headline6: TextStyle(color: ThisAppColors.normalTextColor),
      bodyText1: TextStyle(color: ThisAppColors.normalTextColor),
      bodyText2: TextStyle(color: ThisAppColors.normalTextColor),
      button: TextStyle(color: ThisAppColors.normalTextColor),
      caption: TextStyle(color: ThisAppColors.normalTextColor),
      overline: TextStyle(color: ThisAppColors.normalTextColor),
      subtitle1: TextStyle(color: ThisAppColors.normalTextColor),
      subtitle2: TextStyle(color: ThisAppColors.normalTextColor),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: ThisAppColors.drawerBgColor,
      //scrimColor: ThisAppColors.drawerScrimColor,
    ),
    unselectedWidgetColor: ThisAppColors.inputFieldBgColor,
    iconTheme: const IconThemeData(
      color: ThisAppColors.bgColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: Size(buttonsMinWidth, buttonsMinHeight),
        backgroundColor: Colors.grey,
      ),
    ),
    /*elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
      ),
    ),*/
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(buttonsMinWidth, buttonsMinHeight),
        backgroundColor: ThisAppColors.secondaryColor,
        //shadowColor: ThisAppColors.normalTextColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorBorder: OutlineInputBorder(
        borderSide: new BorderSide(color: Colors.red, width: bordersWidth),
      ),
      //filled: true,
      //fillColor: ThisAppColors.inputFieldBgColor,
      border: OutlineInputBorder(
        borderSide: new BorderSide(
            color: ThisAppColors.inputFieldBgColor, width: bordersWidth),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: new BorderSide(
            color: ThisAppColors.inputFieldBgColor, width: bordersWidth),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: new BorderSide(
            color: ThisAppColors.primaryColor, width: bordersWidth),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateColor.resolveWith(
          (states) => ThisAppColors.secondaryColor),
      thickness: MaterialStateProperty.resolveWith((states) => scrollBarThick),
      showTrackOnHover: true,
      trackVisibility: MaterialStateProperty.resolveWith((states) => true),
      trackColor: MaterialStateProperty.resolveWith(
          (states) => ThisAppColors.scrollBarColor),
      isAlwaysShown: true,
    ),
  );
}
