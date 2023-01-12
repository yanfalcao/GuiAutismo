import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';

class AppIcons {
  static Widget logo({@required double height, @required double width}) =>
      SvgPicture.asset(
        'assets/icons/logo_v2.svg',
        height: height,
        width: width,
      );

  static Widget facebook({@required double height, @required double width}) =>
      SvgPicture.asset(
        'assets/icons/facebook.svg',
        height: height,
        width: width,
      );

  static Widget google({@required double height, @required double width}) =>
      SvgPicture.asset(
        'assets/icons/google.svg',
        height: height,
        width: width,
      );

  static Widget homeOutline({@required double height, @required double width}) =>
      SvgPicture.asset(
        'assets/icons/home_outline.svg',
        height: height,
        width: width,
        color: AppColors.white,
      );

  static Widget home({@required double height, @required double width}) =>
      SvgPicture.asset(
        'assets/icons/home.svg',
        height: height,
        width: width,
        color: AppColors.white,
      );

  static Widget bookOutline({@required double height, @required double width}) =>
      SvgPicture.asset(
        'assets/icons/book_outline.svg',
        height: height,
        width: width,
        color: AppColors.white,
      );

  static Widget book({@required double height, @required double width}) =>
      SvgPicture.asset(
        'assets/icons/book.svg',
        height: height,
        width: width,
        color: AppColors.white,
      );

  static Widget userOutline({@required double height, @required double width}) =>
      SvgPicture.asset(
        'assets/icons/user_outline.svg',
        height: height,
        width: width,
        color: AppColors.white,
      );

  static Widget user({@required double height, @required double width}) =>
      SvgPicture.asset(
        'assets/icons/user.svg',
        height: height,
        width: width,
        color: AppColors.white,
      );

  static Widget puzzlePiece({
    @required double height,
    @required double width,
    @required Color color
  }) =>
      SvgPicture.asset(
        'assets/icons/puzzle.svg',
        height: height,
        width: width,
        color: color ?? AppColors.white,
      );
}
