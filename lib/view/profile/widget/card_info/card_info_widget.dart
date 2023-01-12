import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardInfoWidget extends StatelessWidget {
  User user;

  CardInfoWidget({this.user});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Container(
      height: 160,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: ContainerDecoration(
          radius: 12,
          color: AppColors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Text(user.displayName,
            style: AppFonts.montserratSemiBold(
              fontSize: 22,
              color: AppColors.black
            ),
          ),
          SizedBox(height: 6),
          Text(user.email,
            style: AppFonts.montserratLight(
              fontSize: 12,
              color: AppColors.blue
            ),
          ),
          SizedBox(height: 25)
        ],
      ),
    );
  }
}
