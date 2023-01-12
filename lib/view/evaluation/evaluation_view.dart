import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/blocs/user_bloc.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/commons/parameters.dart';
import 'package:guiautismo/model/evaluation.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/services/evaluation_service.dart';
import 'package:guiautismo/view/evaluation/widget/app_bar/app_bar_widget.dart';
import 'package:guiautismo/view/evaluation/widget/bool_rating/bool_rating.dart';
import 'package:guiautismo/view/evaluation/widget/comment/comment_widget.dart';
import 'package:guiautismo/view/evaluation/widget/star_rating/star_evaluation_widget.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:overlay_support/overlay_support.dart';

class EvaluationView extends StatelessWidget {
  Place place;
  Evaluation evaluation = Evaluation();

  EvaluationView({
    @required this.place
  });

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBarWidget(title: this.place.name),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...getParametersWidgets(),
              CommentWidget(label: 'Comentário', evaluation: evaluation),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCancelButtom(context, localizations),
                  buildSendButtom(context, localizations)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCancelButtom(BuildContext context, AppLocalizations localizations) => Container(
    height: 35,
    width: 150,
    decoration: ContainerDecoration(
        color: AppColors.lightGrey,
        radius: 20
    ),
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Center(
        child: Text(
          localizations.cancel,
          style: AppFonts.montserratLight(
              fontSize: 18,
              color: AppColors.black
          ),
        ),
      ),
    ),
  );

  Widget buildSendButtom(BuildContext context, AppLocalizations localizations) => Container(
    height: 35,
    width: 150,
    decoration: ContainerDecoration(
        color: AppColors.greenStar,
        radius: 20
    ),
    child: GestureDetector(
      onTap: () {
        bool emptyField = false;
        evaluation.starValues.forEach((element) {
          if(element['score'] == 0){
            emptyField = true;
          }
        });

        if(emptyField){
          showSimpleNotification(
              Text('Preencha todos os campos!',
                style: AppFonts.montserratLight(
                    fontSize: 20,
                    color: AppColors.white
                ),
              ),
              background: AppColors.redAlert,
              duration: Duration(seconds: 2)
          );
        }else {
          UserBloc userBloc = BlocProvider.getBloc<UserBloc>();
          User user = userBloc.userSubject.value;

          evaluation.idUser = user.uid;
          evaluation.nameUser = user.displayName;
          evaluation.photoUser = user.photoURL;
          evaluation.calculateScore();

          (EvaluationService.instance).sendEvaluation(evaluation, place);
          showSimpleNotification(
              Text('Avaliação realizada com sucesso',
                style: AppFonts.montserratLight(
                    fontSize: 20,
                    color: AppColors.white
                ),
              ),
              background: AppColors.lightGreen,
              duration: Duration(seconds: 2)
          );
          Navigator.of(context).pop();
        }
      },
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
  );

  List<Widget> getParametersWidgets() {
    List<Widget> widgets = [];

    for(String key in ParametersConstants.getAllKeysParam(place.typePlace)){
      widgets.add(StarEvaluationWidget(
        idTitle: key,
        typePlace: place.typePlace,
        evaluation: evaluation,
      ));
      widgets.add(SizedBox(height: 20));
    }

    return widgets;
  }
}
