import 'package:flutter/cupertino.dart';

class AppImages {
  static Widget backgroundLoginImage({
    double height = double.maxFinite,
    double width = double.maxFinite
  }) =>
      Container(
        height: height,
        width: width,
        child: Image.asset('assets/images/background.png', fit: BoxFit.fill)
      );
}