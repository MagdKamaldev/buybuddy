// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: indigoDye),
  scaffoldBackgroundColor: ashGrey,
  appBarTheme: AppBarTheme(
      backgroundColor: indigoDye,
      iconTheme: IconThemeData(color: ivory),
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: indigoDye, statusBarBrightness: Brightness.light)),
  textTheme: TextTheme(
    bodyLarge:
        TextStyle(fontSize: 24, color: prussianBlue, fontFamily: "Rubik"),
    titleMedium: TextStyle(
      fontSize: 20,
      color: prussianBlue,
      fontFamily: "Rubik",
    ),
    titleSmall:
        TextStyle(fontSize: 14, color: prussianBlue, fontFamily: "Rubik"),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: indigoDye,
    selectedItemColor: ivory,
    unselectedItemColor: prussianBlue,
    unselectedLabelStyle:
        TextStyle(fontSize: 14, color: prussianBlue, fontFamily: "Rubik"),
    selectedLabelStyle:
        TextStyle(fontSize: 14, color: ivory, fontFamily: "Rubik"),
  ),
  useMaterial3: true,
);
