import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/view/place_info/widget/google_map/google_map_widget.dart';
import 'package:guiautismo/view/place_info/widget/redirect_address/redirect_address_widget.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';

class LocationInfo {
  static List<Widget> build(BuildContext context, {Place place}) {
    final localizations = AppLocalizations.of(context);

    return [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(localizations.location,
              style: AppFonts.montserratLight(
                  fontSize: 16, color: AppColors.black))),
      SizedBox(height: 20),
      GoogleMapWidget(place: place),
      RedirectAddressWidget(address: place.address, placeId: place.placeId),
      Container(
        height: 1,
        width: double.maxFinite,
        color: AppColors.lightGrey,
      ),
      place.isOpen == null
          ? Container()
          : Container(
              height: 45,
              width: double.maxFinite,
              color: AppColors.white,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    place.isOpen ? localizations.open : localizations.close,
                    style: AppFonts.montserratLight(
                        fontSize: 10, color: AppColors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )),
      place.isOpen == null
          ? Container()
          : Container(
              height: 1,
              width: double.maxFinite,
              color: AppColors.lightGrey,
            ),
      Container(
          height: 45,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)
              ),
              boxShadow: [
                BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 6,
                    offset: Offset(1, 3)
                )
              ]
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '${place.distance.toStringAsFixed(1)} Km ' + localizations.away,
                style: AppFonts.montserratLight(
                    fontSize: 10,
                    color: AppColors.black
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
      )
    ];
  }
}
