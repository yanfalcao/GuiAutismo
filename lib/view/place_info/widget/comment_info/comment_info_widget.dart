import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:intl/intl.dart';

class CommentInfo {
  static List<Widget> build(BuildContext context,
      {List<Map<String, dynamic>> comments}){

    final localizations = AppLocalizations.of(context);
    List<Widget> widgets = [];

    if (comments == null || comments.isEmpty) {
      widgets.add(Container());
    } else {
      widgets.add(
        Align(
          alignment: Alignment.centerLeft,
          child: Text(localizations.comments,
              style: AppFonts.montserratLight(
                  fontSize: 16, color: AppColors.black)
          )
        )
      );
      widgets.add(SizedBox(height: 20));

      List<Widget> commentsList = [];
      comments.forEach((element) {
        commentsList.add(_buildComment(element));
        commentsList.add(SizedBox(height: 30));
      });
      commentsList.removeLast();

      widgets.add(
        Container(
          height: 450,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: ContainerDecoration(radius: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: commentsList,
            ),
          ),
        )
      );
    }

    return widgets;
  }

  static Widget _buildComment(Map<String, dynamic> comment){
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 60,
                width: 60,
                child: comment['photoUser'] == null || comment['photoUser'] == ''?
                CircleAvatar(backgroundColor: AppColors.lightBlue) :
                CircleAvatar(backgroundImage: NetworkImage(comment['photoUser']))
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: constraints.maxWidth - 90,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: "${comment['nameUser']}    ",
                      style: AppFonts.montserratSemiBold(
                          fontSize: 14,
                          color: AppColors.black
                      ),
                      children: [
                        TextSpan(
                          text: getFormatTime(comment),
                          style: AppFonts.montserratLight(
                              fontSize: 14,
                              color: AppColors.black
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: constraints.maxWidth - 80,
                  child: Text(
                    comment['comment'],
                    style: AppFonts.montserratLight(
                        fontSize: 14,
                        color: AppColors.black
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            )
          ],
        );
      }
    );
  }

  static String getFormatTime(Map<String, dynamic> comment){
    int timestamp;
    DateTime date;

    try{
      timestamp = comment['lastModified']['_seconds'];
      date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    }catch(e){
      timestamp = comment['lastModified'];
      date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    }

    final months = {
      1: 'Janeiro',
      2: 'Fevereiro',
      3: 'Março',
      4: 'Abril',
      5: 'Maio',
      6: 'Junho',
      7: 'Julho',
      8: 'Agosto',
      9: 'Setembro',
      10: 'Outubro',
      11: 'Novembro',
      12: 'Dezembro'
    };

    return '${months[date.month]} de ${date.year}';
  }
}