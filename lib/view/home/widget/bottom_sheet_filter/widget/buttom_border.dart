import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';

class ButtomBorder extends StatelessWidget {
  String text;
  Color color;
  Function onTap;

  ButtomBorder({this.text, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color ?? AppColors.mediumGrey, width: 1)
        ),
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        child: Text(text,
          style: AppFonts.montserratLight(
              fontSize: 18,
              color: color ?? AppColors.black
          ),
        ),
      ),
    );
  }
}
