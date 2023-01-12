import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';

class ImageNoticeWidget extends StatelessWidget {
  String urlImage;
  Widget child;

  ImageNoticeWidget({
    @required this.urlImage,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
          color: AppColors.lightPinkTransparent,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: AppColors.shadow,
                blurRadius: 6,
                offset: Offset(1, 3)
            )
          ],
          image: DecorationImage(
              image: NetworkImage(urlImage),
              fit: BoxFit.cover
          )
      ),
      child: child,
    );
  }
}
