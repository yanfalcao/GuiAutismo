import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/model/notice.dart';
import 'package:guiautismo/view/notice/widget/image_notice/image_notice_widget.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeTileWidget extends StatelessWidget {
  Notice notice;

  NoticeTileWidget({this.notice})
      : assert(notice != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if(await canLaunch(notice.redirectLink)){
          await launch(notice.redirectLink);
        } else {
          showSimpleNotification(
              Text('Erro: não pode abrir essa página agora',
                style: AppFonts.montserratLight(
                    fontSize: 20,
                    color: AppColors.white
                ),
              ),
              background: AppColors.redAlert,
              duration: Duration(seconds: 2)
          );
        }
      },
      child: ImageNoticeWidget(
        urlImage: notice.urlPhoto,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.lightPinkTransparent,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 90,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notice.title,
                      style: AppFonts.montserratRegular(fontSize: 16, color: AppColors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis
                  ),
                  Text(notice.description,
                    style: AppFonts.montserratLight(fontSize: 12, color: AppColors.black),
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
