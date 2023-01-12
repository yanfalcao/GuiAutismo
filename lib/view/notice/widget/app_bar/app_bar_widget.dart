import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 25),
        child: Center(
          child: Text(localizations.contentTitle,
              style: AppFonts.montserratLight(fontSize: 25, color: AppColors.black)
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
