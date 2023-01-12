import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';

class ButtomFull extends StatelessWidget {
  String text;
  Color color;
  Function onTap;

  ButtomFull({this.text, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        decoration: ContainerDecoration(radius: 20, color: color),
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Center(
          child: Text(text,
            style: AppFonts.montserratLight(fontSize: 18, color: AppColors.black),
          ),
        ),
      ),
    );
  }
}
