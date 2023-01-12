import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/blocs/place_bloc.dart';
import 'package:guiautismo/blocs/user_bloc.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(110);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final searchBloc = BlocProvider.getBloc<PlaceBloc>();
    final userBloc = BlocProvider.getBloc<UserBloc>();

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 110,
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 45,
                decoration: ContainerDecoration(radius: 30),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: _searchDecoration(localizations.hintSearch),
                      onSubmitted: (text) {
                        searchBloc.inSearchText.add(text);
                      },
                      onChanged: (text) {
                        if(text == null || text.isEmpty)
                          searchBloc.inSearchText.add(text);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: AppColors.black,),
                      onPressed: () {
                        searchBloc.inSearchText.add(_controller.value.text);
                      }
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 20),
            SizedBox(
              height: 60,
              width: 60,
              child: userBloc.userSubject.hasValue
                ? CircleAvatar(backgroundImage: NetworkImage(userBloc.userSubject.value.photoURL))
                : CircleAvatar(backgroundColor: AppColors.lightBlue)
            )
          ],
        ),
      )
    );
  }

  InputDecoration _searchDecoration(String text) =>
      InputDecoration(
        hintText: text,
        hintStyle: AppFonts.montserratLight(fontSize: 13, color: AppColors.mediumGrey),
        border: _border(),
        focusedBorder: _border(),
        enabledBorder: _border(),
        disabledBorder: _border(),
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.only(left: 20, right: 50)
      );

  OutlineInputBorder _border() =>
      OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(style: BorderStyle.none,)
      );
}