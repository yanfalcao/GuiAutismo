import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/blocs/user_bloc.dart';
import 'package:guiautismo/model/user.dart';
import 'package:guiautismo/view/profile/widget/backgroud_profile/background_profile_widget.dart';
import 'package:guiautismo/view/profile/widget/card_info/card_info_widget.dart';
import 'package:guiautismo/view/profile/widget/profile_image/profile_image_widget.dart';
import 'package:guiautismo/view/profile/widget/sign_out_button/sign_out_button_widget.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget{
  UserBloc _userBloc;
  User _user;

  AppBarWidget() {
    this._userBloc = BlocProvider.getBloc<UserBloc>();
    this._user = _userBloc.userSubject.value;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: BackgroundProfileWidget(),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SignOutButtonWidget(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CardInfoWidget(user: _user),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: ProfileImageWidget(urlImage: _user.photoURL),
              ),
            )
          ],
        )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(285);
}
