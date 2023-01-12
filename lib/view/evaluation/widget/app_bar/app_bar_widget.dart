import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  String title;

  AppBarWidget({
    @required this.title
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 26,
                color: AppColors.darkBlue,
              ),
              onPressed: () {Navigator.of(context).pop();}
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(this.title,
              style: AppFonts.montserratLight(
                  fontSize: 25,
                  color: AppColors.darkBlue
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}