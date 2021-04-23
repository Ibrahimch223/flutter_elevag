class PostModel {
  String nom;
  String quantite, date_aliment;
  String user;
  String id_aliment;
  PostModel({this.nom, this.quantite, this.user, this.id_aliment, this.date_aliment});

  factory PostModel.fromJson(Map<String, dynamic> j){
    return PostModel(
        id_aliment: j['id_aliment'],
        user: j['id_user'],
        nom: j['nom'],
        quantite: j['quantite'],
        date_aliment: j['date_aliment']
    );
  }

  Map toMap(){
    return {
      "id_aliment": id_aliment,
      "id_user": user,
      "nom": nom,
      "quantite": quantite,
      "date_aliment": date_aliment
    };
  }
}