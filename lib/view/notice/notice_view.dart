import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/blocs/notice_bloc.dart';
import 'package:guiautismo/model/notice.dart';
import 'package:guiautismo/view/notice/widget/app_bar/app_bar_widget.dart';
import 'package:guiautismo/view/notice/widget/notice_tile/notice_tile_widget.dart';
import 'package:guiautismo/view/widget/loading/loading_widget.dart';

class NoticeView extends StatelessWidget {
  final noticeBloc = BlocProvider.getBloc<NoticeBloc>();

  @override
  Widget build(BuildContext context) {
    noticeBloc.initNotices();

    return Scaffold(
      appBar: AppBarWidget(),
      body: Container(
        padding: EdgeInsets.only(top: 22),
        child: StreamBuilder<List<Notice>>(
          stream: noticeBloc.outNotices,
          initialData: [],
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return LoadingWidget();
            } else if(snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return NoticeTileWidget(notice: snapshot.data[index],);
                  }
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
