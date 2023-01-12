import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BoolRating extends StatefulWidget {
  String title;

  BoolRating({
    @required this.title
  });

  @override
  _BoolRatingState createState() => _BoolRatingState();
}

class _BoolRatingState extends State<BoolRating> {
  bool selected;

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return Container(
      width: double.maxFinite,
      decoration: ContainerDecoration(radius: 20),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                this.widget.title,
                style: AppFonts.montserratLight(
                    fontSize: 20,
                    color: AppColors.black
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                buildPositiveButtom(localizations),
                Container(
                  height: 40,
                  width: 1,
                  color: AppColors.mediumGrey,
                ),
                buildNegativeButtom(localizations)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildPositiveButtom(AppLocalizations localizations) => Expanded(
    child: GestureDetector(
      onTap: () {
        setState(() {
          selected = true;
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: selected != null && selected ? AppColors.greenStar : AppColors.lightGrey,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))
        ),
        child: Center(
          child: Text(
              localizations.yes,
              style: AppFonts.montserratLight(
                  fontSize: 20,
                  color: AppColors.black
              )
          ),
        ),
      ),
    ),
  );

  Widget buildNegativeButtom(AppLocalizations localizations) => Expanded(
    child: GestureDetector(
      onTap: () {
        setState(() {
          selected = false;
        });
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: selected != null && !selected ? AppColors.greenStar : AppColors.lightGrey,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))
        ),
        child: Center(
          child: Text(
              localizations.no,
              style: AppFonts.montserratLight(
                  fontSize: 20,
                  color: AppColors.black
              )
          ),
        ),
      ),
    ),
  );
}
