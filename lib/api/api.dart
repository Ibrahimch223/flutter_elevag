import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static addAnimaux(Map data) async{
    final response = await http.post(Url.addAnimau, body: {
      "data": jsonEncode(data)
    });

    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      if(result[0]) return result;
      else return null;
    }else{
      return null;
    }
  }

  static getPost()async{
    final response = await http.get(Url.getpost);
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else {
      return null;
    }
  }
  static getPostUser(String id)async{
    final response = await http.post(Url.upost, body:{
      "id_user":id,
      "type": "1"
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else {
      return null;
    }
  }

  static updateAnimaux(Map data) async{
    final response = await http.post(Url.upost, body: {
      "data": jsonEncode(data),
      "type": "2"
    });

    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      if(result[0]) return result;
      else return null;
    }else{
      return null;
    }
  }

  static deleteAnimaux(List data) async{
    final response = await http.post(Url.delete, body: {
      "id_animals": jsonEncode(data),
    });

    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      if(result[0]) return result;
      else return null;
    }else{
      return null;
    }
  }

  static addPost(Map data) async{
    final response = await http.post(Url.addPost, body: {
      "data": jsonEncode(data)
    });

    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      if(result[0]) return result;
      else return null;
    }else{
      return null;
    }
  }

  static getAliment()async{
    final response = await http.get(Url.getAliment);
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else {
      return null;
    }
  }

  static getAlimentUser(String id)async{
    final response = await http.post(Url.gpost, body:{
      "id_user":id,
      "type": "1"
    });
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else {
      return null;
    }
  }

  static updateAliment(Map data) async{
    final response = await http.post(Url.gpost, body: {
      "data": jsonEncode(data),
      "type": "2"
    });

    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      if(result[0]) return result;
      else return null;
    }else{
      return null;
    }
  }

  static deleteAliment(List data) async{
    final response = await http.post(Url.gelite, body: {
      "id_aliments": jsonEncode(data),
    });

    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      if(result[0]) return result;
      else return null;
    }else{
      return null;
    }
  }

  static ajouterPost(Map data) async{
    final response = await http.post(Url.ajouterPost, body: {
      "data": jsonEncode(data)
    });

    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      if(result[0]) return result;
      else return null;
    }else{
      return null;
    }
  }

  static getDiagnostic()async{
    final response = await http.get(Url.getDiagnostic);
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else {
      return null;
    }
  }
}

class Url{
  static String addAnimau = "https://goldene.000webhostapp.com/GoldenElevage/addAnimaux.php";
  static String getpost = "https://goldene.000webhostapp.com/GoldenElevage/getpost.php";
  static String upost = "https://goldene.000webhostapp.com/GoldenElevage/updateAnimaux.php";
  static String delete = "https://goldene.000webhostapp.com/GoldenElevage/deleteAnimaux.php";
  static String addPost = "https://goldene.000webhostapp.com/GoldenElevage/add.php";
  static String getAliment = "https://goldene.000webhostapp.com/GoldenElevage/getAliment.php";
  static String gpost = "https://goldene.000webhostapp.com/GoldenElevage/updateAliment.php";
  static String gelite = "https://goldene.000webhostapp.com/GoldenElevage/deleteAliment.php";
  static String ajouterPost = "https://goldene.000webhostapp.com/GoldenElevage/ajouterPost.php";
  static String getDiagnostic = "https://goldene.000webhostapp.com/GoldenElevage/getDiagnostic.php";
}