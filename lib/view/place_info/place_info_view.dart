import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/blocs/evaluation_bloc.dart';
import 'package:guiautismo/blocs/notice_bloc.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/services/evaluation_service.dart';
import 'package:guiautismo/view/evaluation/evaluation_view.dart';
import 'package:guiautismo/view/place_info/widget/app_bar/app_bar_widget.dart';
import 'package:guiautismo/view/place_info/widget/comment_info/comment_info_widget.dart';
import 'package:guiautismo/view/place_info/widget/evaluation_info/evaluation_info_widget.dart';
import 'package:guiautismo/view/place_info/widget/location_info/location_info_widget.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guiautismo/view/widget/loading/loading_widget.dart';

class PlaceInfoView extends StatefulWidget {
  Place place;

  PlaceInfoView({@required this.place});

  @override
  _PlaceInfoViewState createState() => _PlaceInfoViewState();
}

class _PlaceInfoViewState extends State<PlaceInfoView> {
  final evaluationBloc = BlocProvider.getBloc<EvaluationBloc>();

  @override
  void initState() {
    super.initState();
    evaluationBloc.initParameters(widget.place.placeId);
    evaluationBloc.initComments(widget.place.placeId);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return RefreshIndicator(
      onRefresh: () async {
        evaluationBloc.initParameters(widget.place.placeId);
        evaluationBloc.initComments(widget.place.placeId);
      },
      child: Scaffold(
        appBar: AppBarWidget(place: widget.place),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 22),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => EvaluationView(place: this.widget.place)
                        )
                    );
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: 50,
                    decoration: ContainerDecoration(
                      radius: 6,
                      color: AppColors.greenPuzzle
                    ),
                    child: Center(
                      child: Text(localizations.evaluate,
                        style: AppFonts.montserratLight(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 26),
                ...LocationInfo.build(context, place: widget.place),
                SizedBox(height: 26),
                StreamBuilder<List<dynamic>>(
                  initialData: [],
                  stream: evaluationBloc.outParameters,
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if(snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: EvaluationInfo.build(context,
                            place: widget.place,
                            params: [...snapshot.data]
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(height: 26),
                StreamBuilder<List<dynamic>>(
                  initialData: [],
                  stream: evaluationBloc.outComments,
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if(snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: CommentInfo.build(context,
                            comments: [...snapshot.data]
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
