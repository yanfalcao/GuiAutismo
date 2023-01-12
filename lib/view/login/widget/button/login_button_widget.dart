import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';

class LoginButtonWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final Widget icon;
  final String text;
  final VoidCallback onTap;

  LoginButtonWidget({
    this.height = double.maxFinite,
    this.width = double.maxFinite,
    this.color,
    this.textColor,
    @required this.icon,
    @required this.text,
    @required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGrey,
              blurRadius: 6,
              offset: Offset(1, 3)
            )
          ]
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: icon
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(text,
                style: AppFonts.notoSansRegular(fontSize: 15, color: textColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
