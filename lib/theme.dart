import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const hotPink = Color(0xFFFF3EA5);
  static const bubblegum = Color(0xFFFF8FCB);
  static const babyPink = Color(0xFFFFD6EC);
  static const cocoa = Color(0xFF3A1F26);
  static const teal = Color(0xFF3DD6C6);
  static const lilac = Color(0xFFC9A7FF);
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.hotPink),
    scaffoldBackgroundColor: AppColors.babyPink,
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(
      fontFamily: GoogleFonts.quicksand().fontFamily,
      bodyColor: AppColors.cocoa,
      displayColor: AppColors.cocoa,
    ),
  );
}