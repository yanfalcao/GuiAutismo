import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:guiautismo/commons/map_key.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/services/resources_service.dart';
import 'package:http/http.dart' as http;

class PlaceService {
  static PlaceService _instance;

  PlaceService._();

  static PlaceService get instance {
    if(_instance == null)
      _instance = PlaceService._();
    return _instance;
  }

  Future<List<Place>> fetchPlaces() async {
    List<Place> places = [];

    int radius = 6000;
    Position position = await ResourcesService.getCurrentPosition();
    String typeSupermarket = 'supermarket';
    String typeCinema = 'movie_theater';

    String urlSupermarket = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=${radius}&type=${typeSupermarket}&keyword=brazil&key=${MapKey.apiKey}';
    String urlCinema = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=${radius}&type=${typeCinema}&keyword=brazil&key=${MapKey.apiKey}';

    http.Response response = await http.get(Uri.parse(urlSupermarket));
    var values = jsonDecode(response.body);
    places = values['results']
        .map<Place>((json) {
          Place p = _parsePlace(json, position);

          if(p.typePlace != null){
            return p;
          }
        }).toList();

    response = await http.get(Uri.parse(urlCinema));
    values = jsonDecode(response.body);
    places += values['results']
        .map<Place>((json) {
          Place p = _parsePlace(json, position);

          if(p.typePlace != null){
            return p;
          }
        }).toList();

    for(Place p in places){
      p = await _fetchPlaceScore(p);
    }

    return places;
  }

  Future<List<Place>> fetchPlacesSearch(String search) async {
    List<Place> places  = [];

    Position position = await ResourcesService.getCurrentPosition();
    int radius = 100000;
    String region = 'br';
    String type = 'supermarket,movie_theater';

    String url = 'https://maps.googleapis.com/maps/api/place/textsearch/json'+
        '?radius=${radius}'+
        '&query=${search}'+
        '&location=${position.latitude},${position.longitude}&'+
        'region=${region}'+
        '&type=${type}'+
        '&key=${MapKey.apiKey}';


    http.Response response = await http.get(Uri.parse(url));
    var values = jsonDecode(response.body);
    places = values['results']
        .map<Place>((json) {
          Place p = _parsePlace(json, position);

          if(p.typePlace != null){
            return p;
          }
          return null;
        }).toList();

    places.removeWhere((element) => element == null);

    for(Place p in places){
      p = await _fetchPlaceScore(p);
    }

    return places;
  }

  Future<List<Place>> fetchEvaluatedPlaces(String userId) async {
    List<Place> places  = [];
    List<String> placesId = [];
    String url = 'https://us-central1-guiautismo-318602.cloudfunctions.net/api/evaluatedPlaces?userId=${userId}';

    http.Response response = await http.get(Uri.parse(url));
    var values = jsonDecode(response.body);

    if(values.isEmpty){
      return places;
    }

    placesId = values.map<String>((json) {
      return json.toString();
    }).toList();

    for(String id in placesId){
      Place p = await _fetchPlaceById(id);
      if(p == null)
        continue;

      p = await _fetchPlaceScore(p);
      places.add(p);
    }

    return places;
  }

  Future<Place> _fetchPlaceById(String placeId) async{
    Position position = await ResourcesService.getCurrentPosition();

    String url = 'https://maps.googleapis.com/maps/api/place/details/json?placeid=${placeId}&key=${MapKey.apiKey}';

    http.Response response = await http.get(Uri.parse(url));
    var values = jsonDecode(response.body);

    Place p = _parsePlace(values['result'], position);

    return p.typePlace == null ? null : p;
  }

  Future<Place> _fetchPlaceScore(Place place) async {
    String url = 'https://us-central1-guiautismo-318602.cloudfunctions.net/api/placeScore?placeId=${place.placeId}';

    http.Response response = await http.get(Uri.parse(url));
    var value = jsonDecode(response.body);

    place.score = value['score'];

    if(place.score == null){
      place.numberReviews =  0;
      place.accessability = Accessability.NOT_RATED;
    }else{
      place.numberReviews = value['number_reviews'];

      if(place.score <= 2){
        place.accessability = Accessability.NOT_ACCESSIBLE;
      }else if(place.score > 2 && place.score < 4){
        place.accessability = Accessability.PARTIALLT_ACCESSIBLE;
      }else{
        place.accessability = Accessability.ACCESSIBLE;
      }
    }

    return place;
  }

  Place _parsePlace(Map<String, dynamic> json, Position position){
    Place place = Place.fromJson(json);
    place.distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        place.position.latitude,
        place.position.longitude
    ) / 1000;

    return place;
  }
}