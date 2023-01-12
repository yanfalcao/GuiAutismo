import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/view/place_info/place_info_view.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:guiautismo/view/widget/icons/app_icons.dart';

class PlaceTile extends StatelessWidget {
  Place place;

  PlaceTile({@required this.place});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PlaceInfoView(place: place))
        );
      },
      child: Container(
        height: 80,
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: ContainerDecoration(radius: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildImage(),
            Expanded(child: buildInfo()),
            buildSubtitle()
          ],
        ),
      ),
    );
  }

  Widget buildSubtitle() {
    return Container(
      width: 50,
      padding: EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: place.score == null ?
            Text('') :
            Text('${place.score.toStringAsFixed(1)}',
              style: AppFonts.montserratLight(fontSize: 20, color: AppColors.black),
            ),
      ),
    );
  }

  Widget buildInfo() =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 11),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(place.name,
              style: AppFonts.montserratRegular(
                  fontSize: 16,
                  color: AppColors.black
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.getAccessabilityName(),
                  style: AppFonts.montserratLight(
                    fontSize: 11,
                    color: AppColors.black
                  ),
                ),
                SizedBox(height: 1),
                Text('${place.distance.toStringAsFixed(1)} Km',
                  style: AppFonts.montserratLight(
                      fontSize: 11,
                      color: AppColors.black
                  ),
                )
              ],
            )
          ],
        ),
      );

  Widget buildImage() =>
      Container(
        margin: EdgeInsets.only(right: 16),
        height: double.maxFinite,
        width: 100,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15)
            ),
            image: DecorationImage(
                image: place.photoReference == null
                  ? AssetImage('assets/images/no_photo.jpg') 
                  : NetworkImage(place.getPhotoUrl()),
                fit: BoxFit.cover
            )
        ),
      );
}
