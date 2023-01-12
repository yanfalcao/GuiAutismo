import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/commons/parameters.dart';
import 'package:guiautismo/model/evaluation.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:guiautismo/view/widget/star_rating/star_rating_widget.dart';

class StarEvaluationWidget extends StatelessWidget {
  String idTitle;
  TypePlace typePlace;
  Evaluation evaluation;

  StarEvaluationWidget({
    @required this.idTitle,
    @required this.typePlace,
    @required this.evaluation
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration(radius: 20),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                ParametersConstants.getTitleParam(context, typePlace, idTitle),
                style: AppFonts.montserratLight(
                  fontSize: 20,
                  color: AppColors.black
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 35),
            StarRatingWidget(color: AppColors.white,
              evaluation: evaluation,
              idTitle: idTitle,
            )
          ],
        ),
      ),
    );
  }
}
