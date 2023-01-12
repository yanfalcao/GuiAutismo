import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:guiautismo/commons/map_key.dart';
import 'package:guiautismo/model/evaluation.dart';
import 'package:guiautismo/model/place.dart';
import 'package:guiautismo/services/resources_service.dart';
import 'package:http/http.dart' as http;

class EvaluationService {
  static EvaluationService _instance;

  EvaluationService._();

  static EvaluationService get instance {
    if(_instance == null)
      _instance = EvaluationService._();
    return _instance;
  }

  Future<void> sendEvaluation(Evaluation evaluation, Place place) async {

    FirebaseFirestore storage = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> snapshotCollection =
    await storage.collection('places')
        .where('place_id', isEqualTo: place.placeId)
        .get();

    if(snapshotCollection.docs == null || snapshotCollection.docs.length == 0){
      storage.collection('places').add({
        'place_id': place.placeId,
        'score': evaluation.score
      })
      .then((value) async {
        await value.collection('evaluations').add(evaluation.toJson());
      });
    }else{
      QuerySnapshot<Map<String, dynamic>> snapshotEval =
      await storage.collection('places')
          .doc(snapshotCollection.docs[0].id)
          .collection('evaluations')
          .where('id_user', isEqualTo: evaluation.idUser)
          .get();

      if(snapshotEval.docs == null || snapshotEval.docs.length == 0){
        await storage.collection('places')
            .doc(snapshotCollection.docs[0].id)
            .collection('evaluations')
            .add(evaluation.toJson());
      }else {
        await storage.collection('places')
            .doc(snapshotCollection.docs[0].id)
            .collection('evaluations')
            .doc(snapshotEval.docs[0].id)
            .update(evaluation.toJson());
      }

      String url = 'https://us-central1-guiautismo-318602.cloudfunctions.net/api/recalculatePlaceScore?placeId=${place.placeId}';
      http.Response response = await http.get(Uri.parse(url));
    }
  }

  Future<List<dynamic>> fetchParametersScore(String placeId) async {
    String url = 'https://us-central1-guiautismo-318602.cloudfunctions.net/api/parametersScore?placeId=${placeId}';

    http.Response response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> fetchComments(String placeId) async {
    String url = 'https://us-central1-guiautismo-318602.cloudfunctions.net/api/comments?placeId=${placeId}';

    http.Response response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }
}