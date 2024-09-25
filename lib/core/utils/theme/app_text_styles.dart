import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart'; // Import your app colors

class AppTextStyles {
  static TextStyle titleStyle = GoogleFonts.sora(
    color: AppColors.buttonTextColor,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subTitleStyle = GoogleFonts.sora(
    color: AppColors.buttonTextColor,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static TextStyle buttonTextStyle = GoogleFonts.sora(
    color: AppColors.buttonTextColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle customButtonTextStyle = GoogleFonts.sora(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );
}
