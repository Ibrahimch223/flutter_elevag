import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserModel {
  String id;
  String nom;
  String prenom;
  String profession;
  String email;

  UserModel({this.id, this.nom, this.prenom, this.email, this.profession});

  static UserModel sessionUser;

  factory UserModel.fromJson(Map<String, dynamic> i) => UserModel(
      id: i['id'],
      nom: i['nom'],
      prenom: i['prenom'],
      profession: i['profession'],
      email: i['email'],
  );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "profession": profession,
        "email": email
      };

  static void saveUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = json.encode(user.toMap());
    sessionUser = user;
    pref.setString("user", data);
    pref.commit();
  }

  static void getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString("user");
    if(data!= null){
      var decode = json.decode(data);
      var user = await UserModel.fromJson(decode);
      sessionUser = user;
    }else{
      sessionUser=null;
    }
  }

  static void logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("user", null);
    sessionUser=null;
    pref.commit();

  }

  UserModel.fromData(Map<String, dynamic> data)
      : id = data['id'],
        nom = data['nom'],
        email = data['email'],
        prenom = data['prenom'],
        profession = data['profession'];

  /// post data into Firestore

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'email': email,
      'prenom': prenom,
      'profession': profession
    };
  }
}
