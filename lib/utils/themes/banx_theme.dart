import 'package:ban_x/utils/constants/banx_colors.dart';
import 'package:ban_x/utils/themes/custom_themes/banx_app_bar_theme.dart';
import 'package:ban_x/utils/themes/custom_themes/banx_bottom_sheet_theme.dart';
import 'package:ban_x/utils/themes/custom_themes/banx_checkbox_theme.dart';
import 'package:ban_x/utils/themes/custom_themes/banx_chip_theme.dart';
import 'package:ban_x/utils/themes/custom_themes/banx_elevated_button_theme.dart';
import 'package:ban_x/utils/themes/custom_themes/banx_outline_button_theme.dart';
import 'package:ban_x/utils/themes/custom_themes/banx_text_theme.dart';
import 'package:ban_x/utils/themes/custom_themes/banx_textfield_theme.dart';
import 'package:flutter/material.dart';

class BanXTheme{
  BanXTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Schyler',
    brightness: Brightness.light,
    primaryColor: BanXColors.primaryColor,
    textTheme: BanXTextTheme.lightTextTheme,
    chipTheme: BanXChipTheme.lightChipTheme,
    scaffoldBackgroundColor: BanXColors.lightBackground,
    appBarTheme: BanXAppBarTheme.lightAppBarTheme,
    checkboxTheme: BanXCheckBoxTheme.lightCheckboxTheme,
    bottomSheetTheme: BanXBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: BanXElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: BanXOutlineButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: BanXTextFieldTheme.lightInputDecorationTheme,
  );


  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Schyler',
    brightness: Brightness.dark,
    primaryColor: BanXColors.primaryColor,
    textTheme: BanXTextTheme.darkTextTheme,
    chipTheme: BanXChipTheme.darkChipTheme,
    scaffoldBackgroundColor: BanXColors.darkBackground,
    appBarTheme: BanXAppBarTheme.darkAppBarTheme,
    checkboxTheme: BanXCheckBoxTheme.darkCheckboxTheme,
    bottomSheetTheme: BanXBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: BanXElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: BanXOutlineButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: BanXTextFieldTheme.darkInputDecorationTheme,
  );
}