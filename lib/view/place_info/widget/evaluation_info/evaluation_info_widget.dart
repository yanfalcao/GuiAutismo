import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/commons/parameters.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class EvaluationInfo {
  static List<Widget> build(BuildContext context,
      {Place place, List<Map<String, dynamic>> params}) {
    final localizations = AppLocalizations.of(context);
    List<Widget> widgets = [];

    if (params == null || params.isEmpty) {
      widgets.add(Container());
    } else {
      widgets.add(Align(
          alignment: Alignment.centerLeft,
          child: Text(localizations.evaluations + ' (${place.numberReviews})',
              style: AppFonts.montserratLight(
                  fontSize: 16, color: AppColors.black))));
      params.forEach((element) {
        widgets.add(SizedBox(height: 20));
        widgets.add(
          _buildStarViewer(
            title: ParametersConstants.getTitleParam(context, place.typePlace, element['title']),
            value: double.parse(element['score'].toString())
          )
        );
      });
    }

    return widgets;
  }

  static Widget _buildStarViewer({String title, double value}) {
    return Container(
      width: double.maxFinite,
      decoration: ContainerDecoration(radius: 20),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 15, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppFonts.montserratLight(
                  fontSize: 18, color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: LinearPercentIndicator(
                    lineHeight: 15,
                    animation: false,
                    percent: value / 5,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: AppColors.lightGreen,
                    backgroundColor: AppColors.lightGrey,
                  ),
                ),
                SizedBox(width: 10),
                Text('${value.toStringAsFixed(1)} / 5',
                    style: AppFonts.montserratLight(
                        fontSize: 16, color: AppColors.black))
              ],
            )
          ],
        ),
      ),
    );
  }

  static Widget _buildBoolViewer({String title}) {
    return Container(
      width: double.maxFinite,
      decoration: ContainerDecoration(radius: 20),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 15, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppFonts.montserratLight(
                  fontSize: 18, color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Sim\n",
                    style: AppFonts.montserratLight(
                        fontSize: 14, color: AppColors.black),
                    children: [
                      TextSpan(
                        text: "70%",
                        style: AppFonts.montserratSemiBold(
                            fontSize: 14, color: AppColors.black),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LinearPercentIndicator(
                    lineHeight: 15,
                    animation: false,
                    percent: 70 / 100,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: AppColors.lightGreen,
                    backgroundColor: AppColors.redAlert,
                  ),
                ),
                SizedBox(width: 10),
                RichText(
                  text: TextSpan(
                    text: "Não\n",
                    style: AppFonts.montserratLight(
                        fontSize: 14, color: AppColors.black),
                    children: [
                      TextSpan(
                        text: "30%",
                        style: AppFonts.montserratSemiBold(
                            fontSize: 14, color: AppColors.black),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
