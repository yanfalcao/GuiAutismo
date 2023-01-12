import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/blocs/place_bloc.dart';
import 'package:guiautismo/blocs/user_bloc.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/view/feedback/feedback_view.dart';
import 'package:guiautismo/view/profile/widget/place_tile/place_tile_widget.dart';
import 'package:guiautismo/view/profile/widget/app_bar/app_bar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';

class ProfileView extends StatelessWidget {
  final placeBloc = BlocProvider.getBloc<PlaceBloc>();
  UserBloc _userBloc;
  User _user;

  ProfileView() {
    this._userBloc = BlocProvider.getBloc<UserBloc>();
    this._user = _userBloc.userSubject.value;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    placeBloc.initEvaluatedPlaces(_user.uid);

    return Scaffold(
      appBar: AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              localizations.evaluatedLocations,
              style: AppFonts.montserratRegular(
                  fontSize: 24,
                  color: AppColors.black
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder<List<Place>>(
              stream: placeBloc.outEvaluated,
              initialData: [],
              builder: (context, snapshot) {
                return SizedBox(
                  height: 160,
                  child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.hasData ? snapshot.data.length : 3,
                      itemBuilder: (context, index) {
                        return PlaceTileWidget(
                            place: snapshot.hasData ? snapshot.data[index] : null
                        );
                      }
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
