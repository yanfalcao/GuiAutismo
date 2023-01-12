import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:guiautismo/blocs/place_bloc.dart';
import 'package:guiautismo/commons/filter_constants.dart';
import 'package:guiautismo/model/place.dart';

class FilterService {
  FilterConstants classificarPorFilter;
  FilterConstants tipoLocalFilter;
  static FilterService _instance;
  List<Place> places = [];

  FilterService._();

  static FilterService get instance {
    if(_instance == null)
      _instance = FilterService._();
    return _instance;
  }

  void filterPlaces( {@required classificarPorFilter, @required tipoLocalFilter}) {
    PlaceBloc bloc = BlocProvider.getBloc<PlaceBloc>();

    if(this.places.isEmpty && bloc.placeSubject.hasValue){
      this.places = bloc.placeSubject.value;
    }

    if ((classificarPorFilter != FilterConstants.NONE) ||
        (tipoLocalFilter != FilterConstants.NONE)) {
      if(this.places.isNotEmpty){
        List<Place> placesHelper = [...places];

        _filterPorClassificacao(classificarPorFilter, placesHelper);
        placesHelper = _filterPorLocal(tipoLocalFilter, placesHelper);

        bloc.inPlaces.add(placesHelper);
      }
    }else{
      if(this.places.isNotEmpty){
        bloc.inPlaces.add(this.places);
      }
    }
  }

  List<Place> _filterPorClassificacao(@required classificarPorFilter, List<Place> places){
    if(classificarPorFilter == FilterConstants.MAIS_ALTA){
      places.sort((Place a,b) {
        double scoreA = a.score ?? 0;
        double scoreB = b.score ?? 0;
        return scoreA > scoreB ? -1: 1;
      });
    }else if(classificarPorFilter == FilterConstants.MAIS_BAIXA){
      places.sort((Place a,b) {
        double scoreA = a.score ?? 0;
        double scoreB = b.score ?? 0;
        return scoreA > scoreB ? 1: -1;
      });
    }
  }

  List<Place> _filterPorLocal(@required tipoLocalFilter, List<Place> places){
    if(tipoLocalFilter == FilterConstants.SUPERMERCADO){
      return places.where((place) => place.typePlace == TypePlace.SUPERMERCADO).toList();
    } else if(tipoLocalFilter == FilterConstants.CINEMA){
      return places.where((place) => place.typePlace == TypePlace.CINEMA).toList();
    }
    return places;
  }
}
