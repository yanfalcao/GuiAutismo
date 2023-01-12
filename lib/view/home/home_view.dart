import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/blocs/bottom_navigation_bloc.dart';
import 'package:guiautismo/view/home/home_body_view.dart';
import 'package:guiautismo/view/home/widget/bottom_navigation/bottom_navigation_widget.dart';
import 'package:guiautismo/view/notice/notice_view.dart';
import 'package:guiautismo/view/profile/profile_view.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _HOME_INDEX = 0;
    final _CONTENT_INDEX = 1;

    final navigationBloc = BlocProvider.getBloc<BottomNavigationBloc>();

    return Scaffold(
      body: StreamBuilder<int>(
        stream: navigationBloc.outCurrentIndex,
        initialData: 0,
        builder: (context, snapshot) {
          if(snapshot.data == _HOME_INDEX)
            return HomeBodyView();
          else if(snapshot.data == _CONTENT_INDEX)
            return NoticeView();
          else
            return ProfileView();
        },
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
