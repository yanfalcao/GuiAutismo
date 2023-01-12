import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/services/place_service.dart';
import 'package:rxdart/rxdart.dart';

class PlaceBloc implements BlocBase {
  List<Place> places = [];
  final _placeSubject = BehaviorSubject<List<Place>>();

  BehaviorSubject get placeSubject => _placeSubject;
  Sink get inPlaces => _placeSubject.sink;
  Stream get outPlaces => _placeSubject.stream;

  final _placeEvaluatedSubject = BehaviorSubject<List<Place>>();

  Sink get inEvaluated => _placeEvaluatedSubject.sink;
  Stream get outEvaluated => _placeEvaluatedSubject.stream;

  final _searchText = BehaviorSubject<String>();

  Sink get inSearchText => _searchText.sink;

  PlaceBloc() {
    _searchText.stream.listen(_fetchPlaces);
  }

  Future<void> initEvaluatedPlaces(String userId) async {
    places = await (PlaceService.instance).fetchEvaluatedPlaces(userId);

    inEvaluated.add(places);
  }

  void initPlaces(){
    inSearchText.add('');
  }

  void _fetchPlaces(String search) async {
    if(search == null || search.isEmpty){
      inPlaces.add(null);
      places = await (PlaceService.instance).fetchPlaces();
    }else {
      inPlaces.add(null);
      places = await (PlaceService.instance).fetchPlacesSearch(search);
    }
    places.sort((a, b) => a.distance.compareTo(b.distance));
    inPlaces.add(places);
  }

  @override
  void dispose() {
    _placeSubject.close();
    _searchText.close();
    _placeEvaluatedSubject.close();
  }

  @override
  void addListener(listener) {}

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}
}