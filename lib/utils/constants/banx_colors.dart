import 'package:flutter/material.dart';

class BanXColors {
  
  BanXColors._();
  
  /// App Basic Colors
  static const Color primaryColor = Color(0xFF4b68ff);
  static const Color secondaryColor = Color(0xFFffe24b);
  static const Color accentColor = Color(0xFFb0c7ff);

  /// Gradient Colors
  static const Gradient linearGradient = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        Color(0xFFff9a9e),
        Color(0xFFfad0c4),
        Color(0xFFfad0c4),
      ]);

  /// Text Colors
  static const Color primaryTextColor = Color(0xFF333333);
  static const Color secondaryTextColor = Color(0xFF6c757d);

  /// Background Colors
  static const Color lightBackground = Color(0xFFf6f6f6);
  static const Color darkBackground = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFf3f5ff);

  /// Background Container Colors
  static const Color lightContainer = Color(0xFFf6f6f6);
  static Color darkContainer = BanXColors.white.withOpacity(0.1);

  /// Button Colors
  static const Color primaryBtnColor = Color(0xFF4b68ff);
  static const Color secondaryBtnColor = Color(0xFF6c757d);
  static const Color disabledBtnColor = Color(0xFFc4c4c4);

  /// Error and Validation Colors
  static const Color errorColor = Color(0xFFd32f2f);
  static const Color successColor = Color(0xFF388e3c);
  static const Color warningColor = Color(0xFFf57c00);
  static const Color infoColor = Color(0xFF1976d2);

  /// Neutral Colors
  static const Color black = Color(0xFF232323);
  static const Color darkGrey = Color(0xFF939393);
  static const Color darkerGrey = Color(0xFF4f4f4f);
  static const Color grey = Color(0xFFe0e0e0);
  static const Color softGrey = Color(0xFFf4f4f4);
  static const Color lightGrey = Color(0xFFf9f9f9);
  static const Color white = Color(0xFFffffff);
}