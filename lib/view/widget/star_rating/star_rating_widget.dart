import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/model/evaluation.dart';

class StarRatingWidget extends StatefulWidget {
  Color color;
  String idTitle;
  Evaluation evaluation;

  StarRatingWidget({
    this.color,
    @required this.idTitle,
    @required this.evaluation
  });

  @override
  _StarRatingWidgetState createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  Color color;
  int rate;

  @override
  void initState() {
    color = widget.color ?? AppColors.background;
    rate = 0;

    widget.evaluation.starValues.add({
      'title': widget.idTitle,
      'score': rate
    });

    super.initState();
  }

  void changeStarRatingColor(int rate) {
    setState(() {
      this.rate = rate;

      widget.evaluation.starValues.forEach((element) {
        if(element['title'] == widget.idTitle){
          element['score'] = this.rate;
        }
      });

      switch(rate){
        case 1:
          color = AppColors.redPuzzle;
          break;
        case 2:
          color = AppColors.yellowStar;
          break;
        case 3:
          color = AppColors.yellowStar;
          break;
        case 4:
          color = AppColors.greenStar;
          break;
        case 5:
          color = AppColors.greenStar;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () { changeStarRatingColor(1); },
          child: starBorderIcon(
              color: rate > 0 ? color : AppColors.background
          )
        ),
        GestureDetector(
            onTap: () { changeStarRatingColor(2); },
            child: starBorderIcon(
                color: rate > 1 ? color : AppColors.background
            )
        ),
        GestureDetector(
            onTap: () { changeStarRatingColor(3); },
            child: starBorderIcon(
                color: rate > 2 ? color : AppColors.background
            )
        ),
        GestureDetector(
            onTap: () { changeStarRatingColor(4); },
            child: starBorderIcon(
                color: rate > 3 ? color : AppColors.background
            )
        ),
        GestureDetector(
            onTap: () { changeStarRatingColor(5); },
            child: starBorderIcon(
                color: rate > 4 ? color : AppColors.background
            )
        )
      ],
    );
  }
}

Widget starBorderIcon({@required Color color}){
  return Stack(
    alignment: Alignment.center,
    children: [
      Icon(
        Icons.star,
        size: 40,
        color: Colors.grey[600],
      ),
      Icon(
        Icons.star,
        size: 30,
        color: color,
      )
    ],
  );
}
