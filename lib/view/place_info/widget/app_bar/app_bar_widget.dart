import 'package:flutter/material.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/view/widget/decoration/container_decoration.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guiautismo/view/widget/icons/app_icons.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget{
  Place place;

  AppBarWidget({@required this.place});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    String typePlaceName = place.typePlace == TypePlace.CINEMA
        ? localizations.cinema
        : localizations.supermarket;

    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 230,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: place.photoReference == null
                      ? AssetImage('assets/images/no_photo.jpg')
                      : NetworkImage(place.getPhotoUrl()),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 26,
              ),
              onPressed: () { Navigator.of(context).pop(); }
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 95,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: ContainerDecoration(radius: 5),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(place.name,
                            style: AppFonts.montserratLight(
                              fontSize: 16,
                              color: AppColors.black
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(height: 2),
                          Text(typePlaceName,
                            style: AppFonts.montserratLight(
                                fontSize: 10,
                                color: AppColors.mediumGrey
                            )
                          ),
                          Expanded(child: SizedBox(width: 1)),
                          Text(getAccessabilityName(place.accessability, localizations),
                              style: AppFonts.montserratLight(
                                  fontSize: 11,
                                  color: AppColors.mediumGrey
                              )
                          )
                        ],
                      ),
                    ),
                    buildSubtitle()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(275);

  Widget buildSubtitle() {
    return Text(place.score == null ? '' : place.score.toStringAsFixed(1),
      style: AppFonts.montserratLight(
          fontSize: 30,
          color: AppColors.black
      ),
      maxLines: 1,
    );
  }

  String getAccessabilityName(Accessability accessability, AppLocalizations localizations){
    switch(accessability){
      case Accessability.ACCESSIBLE:
        return localizations.accessible;
      case Accessability.PARTIALLT_ACCESSIBLE:
        return localizations.partialltAccessible;
      case Accessability.NOT_ACCESSIBLE:
        return localizations.notAccessible;
      case Accessability.NOT_RATED:
        return localizations.notRated;
    }
  }
}
