import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/view/place_info/place_info_view.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';

class PlaceTileWidget extends StatelessWidget {
  Place place;

  PlaceTileWidget({@required this.place});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PlaceInfoView(place: place))
        );
      },
      child: Container(
        height: 150,
        width: 150,
        margin: EdgeInsets.only(right: 15, left: 1),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: AppColors.shadow, blurRadius: 6, offset: Offset(1, 3))
            ],
            image: place == null
                ? null
                : DecorationImage(
                  image: place.photoReference == null
                      ? AssetImage('assets/images/no_photo.jpg')
                      : NetworkImage(place.getPhotoUrl()),
                  fit: BoxFit.cover
                )
        ),
        child: place == null
            ? Container()
            : _buildCard(),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      decoration: BoxDecoration(
          color: place.photoReference == null
              ? AppColors.pinkTransparent
              : AppColors.lightOrangeTransparent,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 4),
          child: Text(
            place.name,
            style: AppFonts.montserratRegular(fontSize: 15,
                color: place.photoReference == null ? AppColors.black : AppColors.white),
          ),
        ),
      ),
    );
  }
}