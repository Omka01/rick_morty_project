import 'package:flutter/material.dart';
import 'package:test_rick/config/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.irisBlue
    primary: AppColors.irisBlue,
    surface: AppColors.whiteSmoke,
    brightness: Brightness.light,
  ),
  textTheme: textTheme.apply(
    fontFamily: GoogleFonts.lato().fontFamily,
    bodyColor: AppColors.nero,
  ),
);
const textTheme = TextTheme();

class FontStyles {
  static const double _largeFontSize = 16;
  static const double _mediumFontSize = 14;
  static const double _smallFontSize = 12;


  static const TextStyle subtitleBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontStyle: _largeFontSize,
  );
  static const TextStyle bodyBold = TextStyle(
    fontWeight: FontWeight.w700,
    fontStyle: _mediumFontSize,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontWeight: FontWeight.w500,
    fontStyle: _mediumFontSize,
  );
  static const TextStyle captionMedium = TextStyle(
    fontWeight: FontWeight.w700,
    fontStyle: _smallFontSize,
  );
}