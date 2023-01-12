import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';

class BackgroundProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_profile.png'),
              fit: BoxFit.cover
          )
      ),
      child: Container(
        color: AppColors.lightBlueTransparent,
      ),
    );
  }
}
