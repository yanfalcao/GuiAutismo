class Evaluation {
  double score;
  String comment;
  String idUser;
  String nameUser;
  String photoUser;
  List<Map<String, dynamic>> starValues;

  Evaluation({
    this.score,
    this.comment,
    this.idUser,
    this.nameUser,
    this.photoUser,
    this.starValues
  }){
    starValues = [];
  }

  Map<String, dynamic> toJson() => {
    'comment': comment,
    'id_user': idUser,
    'last_modified': DateTime.now().millisecondsSinceEpoch,
    'name_user': nameUser,
    'photo_user': photoUser,
    'score': score,
    'star_values': starValues
  };

  calculateScore(){
    var sumScore = 0;
    starValues.forEach((element) {
      sumScore += element['score'];
    });

    score = sumScore / starValues.length;
  }
}