import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class ResourcesService{
  static Future<bool> hasInternetConnection() async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;

    if(!hasInternet){
      showSimpleNotification(
        Text('Você está sem internet',
          style: AppFonts.montserratLight(
            fontSize: 20,
            color: AppColors.white
          ),
        ),
        background: AppColors.redAlert,
        duration: Duration(seconds: 2)
      );
    }

    return hasInternet;
  }

  static Future<bool> isLocationPermanentlyDenied() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.deniedForever){
      showSimpleNotification(
          Text('A permissão para o uso do GPS está negada',
            style: AppFonts.montserratLight(
                fontSize: 20,
                color: AppColors.white
            ),
          ),
          background: AppColors.redAlert,
          duration: Duration(seconds: 2)
      );

      return true;
    }
    return false;
  }

  static Future<bool> isLocationDenied() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        showSimpleNotification(
            Text('A permissão para o uso do GPS está negada',
              style: AppFonts.montserratLight(
                  fontSize: 20,
                  color: AppColors.white
              ),
            ),
            background: AppColors.redAlert,
            duration: Duration(seconds: 2)
        );
        return true;
      }
    }
    return false;
  }

  static Future<bool> isLocationEnabled() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();

    if(!enabled){
      showSimpleNotification(
          Text('Por favor, ligue o GPS',
            style: AppFonts.montserratLight(
                fontSize: 20,
                color: AppColors.white
            ),
          ),
          background: AppColors.redAlert,
          duration: Duration(seconds: 2)
      );
    }
    return enabled;
  }

  static Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }
}