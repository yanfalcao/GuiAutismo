import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';

class AppFonts {
  static TextStyle montserratSemiBold({
    Color color,
    @required double fontSize
  }) =>
      GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
          color: color ?? AppColors.white,
          fontSize: fontSize
      );

  static TextStyle montserratMedium({
    Color color,
    @required double fontSize
  }) =>
      GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          color: color ?? AppColors.white,
          fontSize: fontSize
      );

  static TextStyle montserratRegular({
    Color color,
    @required double fontSize
  }) =>
      GoogleFonts.montserrat(
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.white,
        fontSize: fontSize
      );

  static TextStyle montserratLight({
    Color color,
    @required double fontSize,
    double height
  }) =>
      GoogleFonts.montserrat(
          fontWeight: FontWeight.w300,
          color: color ?? AppColors.white,
          fontSize: fontSize,
          height: height
      );

  static TextStyle notoSansRegular({
    Color color,
    @required double fontSize
  }) =>
      GoogleFonts.notoSans(
          fontWeight: FontWeight.w400,
          color: color ?? AppColors.white,
          fontSize: fontSize
      );
}