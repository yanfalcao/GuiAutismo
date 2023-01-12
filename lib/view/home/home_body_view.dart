import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:guiautismo/blocs/place_bloc.dart';
import 'package:guiautismo/commons/colors/app_colors.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/services/resources_service.dart';
import 'package:guiautismo/view/home/widget/app_bar/app_bar_widget.dart';
import 'package:guiautismo/view/home/widget/button_filter/button_filter_widget.dart';
import 'package:guiautismo/view/home/widget/place_tile/place_tile.dart';
import 'package:guiautismo/view/widget/fonts/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guiautismo/view/widget/loading/loading_widget.dart';

class HomeBodyView extends StatefulWidget {
  @override
  _HomeBodyViewState createState() => _HomeBodyViewState();
}

class _HomeBodyViewState extends State<HomeBodyView> {
  final placeBloc = BlocProvider.getBloc<PlaceBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBarWidget(),
      body: Container(
        padding: EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          children: [
            buildFilterRow(localizations),
            SizedBox(height: 22),
            FutureBuilder(
              future: _initPlaceState(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingWidget();
                } else {
                  return StreamBuilder<List<Place>>(
                    stream: placeBloc.outPlaces,
                    initialData: [],
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingWidget();
                      } else if(snapshot.connectionState == ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        if(snapshot.hasData) {
                          return Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return PlaceTile(place: snapshot.data[index]);
                                }
                            ),
                          );
                        } else {
                          return LoadingWidget();
                        }
                      }
                      return Container();
                    },
                  );
                }
              }
            )
          ],
        ),
      ),
    );
  }

  Widget buildFilterRow(AppLocalizations localizations) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.locationsClose,
              style: AppFonts.montserratLight(fontSize: 20, color: AppColors.black),
            ),
            ButtonFilterWidget()
          ],
        ),
      );

  Future<void> _initPlaceState() async {
    _checkInternetConnection();
    _checkGPS();

    placeBloc.initPlaces();
  }

  Future<void> _checkInternetConnection() async {
    if(! await ResourcesService.hasInternetConnection()){
      Future.delayed(Duration(seconds: 7))
          .then((value) => _checkInternetConnection());
    }
  }

  Future<void> _checkGPS() async {
    if(await ResourcesService.isLocationPermanentlyDenied()){
      if(await ResourcesService.isLocationDenied()){
        Future.delayed(Duration(seconds: 8))
            .then((value) => _checkGPS());
      }
    }else if(!await ResourcesService.isLocationEnabled()){
      Future.delayed(Duration(seconds: 7))
          .then((value) => _checkGPS());
    }
  }
}
