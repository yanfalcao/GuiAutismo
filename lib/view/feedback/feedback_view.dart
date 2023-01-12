import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/feedback/widget/app_bar/app_bar_widget.dart';
import 'package:guiautismo/view/feedback/widget/custom_field/custom_field_widget.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:guiautismo/view/widget/star_rating/star_rating_widget.dart';

class FeedbackView extends StatefulWidget {
  @override
  _FeedbackViewState createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBarWidget(),
      body: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              localizations.rateTitle,
              style: AppFonts.montserratLight(
                fontSize: 26,
                color: AppColors.black,
                height: 1.8
              ),
              textAlign: TextAlign.center
            ),
            SizedBox(height: 20),
            StarRatingWidget(),
            SizedBox(height: 50),
            CustomFieldWidget(
                height: 45.0,
                label: localizations.title
            ),
            SizedBox(height: 20),
            CustomFieldWidget(
                height: 165.0,
                label: localizations.message
            ),
            SizedBox(height: 100),
            Container(
              height: 35,
              width: 150,
              decoration: ContainerDecoration(
                color: AppColors.greenStar,
                radius: 20
              ),
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: Text(
                    localizations.send,
                    style: AppFonts.montserratLight(
                      fontSize: 18,
                      color: AppColors.black
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}