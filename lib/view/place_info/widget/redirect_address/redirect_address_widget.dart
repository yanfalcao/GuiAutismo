import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

class RedirectAddressWidget extends StatelessWidget {
  String placeId;
  String address;

  RedirectAddressWidget({
    @required this.address,
    @required this.placeId
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String urlMap = "https://www.google.com/maps/search/?api=1&query=${address}&query_place_id=${placeId}";
        if(await canLaunch(urlMap)){
          await launch(urlMap);
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
      child: Container(
        height: 45,
        width: double.maxFinite,
        color: AppColors.white,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              address,
              style: AppFonts.montserratLight(
                  fontSize: 10,
                  color: AppColors.black
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
