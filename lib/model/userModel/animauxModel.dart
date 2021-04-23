class AnimauxModel {
  String espece;
  String matricule;
  String image;
  String user;
  String id_animaux;
  AnimauxModel({this.espece, this.matricule, this.image, this.user, this.id_animaux});

  factory AnimauxModel.fromJson(Map<String, dynamic> j){
    return AnimauxModel(
      id_animaux: j['id_animaux'],
      user: j['id_user'],
      espece: j['espece'],
      matricule: j['matricule'],
      image: j['image']
    );
  }

  Map toMap(){
    return {
      "id_animaux": id_animaux,
      "id_user": user,
      "espece": espece,
      "matricule": matricule,
      "image": image
    };
  }
}