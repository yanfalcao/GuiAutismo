import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/home/widget/bottom_sheet_filter/bottom_sheet_filter.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonFilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return GestureDetector(
      onTap: (){
        BottomSheetFilter.build(context);
      },
      child: Container(
        height: 25,
        width: 90,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: ContainerDecoration(radius: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.filter,
              style: AppFonts.montserratLight(
                fontSize: 12,
                color: AppColors.black
              ),
            ),
            Icon(
              Icons.filter_alt_outlined,
              color: AppColors.black,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}
