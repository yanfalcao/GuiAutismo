import 'package:geolocator/geolocator.dart';
import 'package:guiautismo/commons/map_key.dart';

enum Accessability{
  ACCESSIBLE,
  PARTIALLT_ACCESSIBLE,
  NOT_ACCESSIBLE,
  NOT_RATED
}

enum TypePlace{
  CINEMA,
  SUPERMERCADO
}

class Place {
  String placeId;
  String name;
  TypePlace typePlace;
  Accessability accessability;
  num score;
  double distance;
  Position position;
  String photoReference;
  bool isOpen;
  String address;
  int numberReviews;

  Place.fromJson(Map<String, dynamic> json) {
    _getPosition(json);
    this.name = json['name'];
    this.isOpen = json['opening_hours'] != null
        ? json['opening_hours']['open_now']
        : null;
    if (json['photos'] != null) {
      this.photoReference = json['photos'][0]['photo_reference'];
    }
    this.placeId = json['place_id'];
    _getTypePlace(json);
    this.address = json['vicinity'] ?? json['formatted_address'];
  }

  Place({
    this.placeId,
    this.name,
    this.typePlace,
    this.accessability,
    this.score,
    this.distance,
    this.position,
    this.photoReference,
    this.isOpen,
    this.address,
  });


  String getAccessabilityName(){
    switch(accessability){
      case Accessability.ACCESSIBLE:
        return 'Acessivel';
      case Accessability.PARTIALLT_ACCESSIBLE:
        return 'Parcialmente Acessivel';
      case Accessability.NOT_ACCESSIBLE:
        return 'Não Acessivel';
      case Accessability.NOT_RATED:
        return 'Não Avaliado';
    }
  }

  String getTypePlaceName(){
    switch(typePlace){
      case TypePlace.CINEMA:
        return 'Cinema';
      case TypePlace.SUPERMERCADO:
        return 'Supermercado';
    }
  }

  String getPhotoUrl(){
    return 'https://maps.googleapis.com/maps/api/place/photo?photo_reference=${this.photoReference}&maxwidth=400&key=${MapKey.apiKey}';
  }

  void _getPosition(Map<String, dynamic> json){
    this.position = json['geometry'] != null
    ? Position(
        longitude: double.parse(json['geometry']['location']['lng'].toString()),
        latitude: double.parse(json['geometry']['location']['lat'].toString()),
        timestamp: null,
        accuracy: null,
        altitude: null,
        heading: null,
        speed: null,
        speedAccuracy: null)
    : null;
  }

  void _getTypePlace(Map<String, dynamic> json) {
    List<String> types = json['types'].cast<String>();
    if(types.contains('supermarket')){
      this.typePlace = TypePlace.SUPERMERCADO;
    } else if(types.contains('movie_theater')){
      // movie_theater
      this.typePlace = TypePlace.CINEMA;
    }
  }
}