import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_elevage/Acceuil/acceuil.dart';
import 'package:flutter_elevage/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:flutter_elevage/model/userModel/userModel.dart';
import 'package:flutter_elevage/widgets/customTextField.dart';
import 'package:http/http.dart' as http;

class Profil extends StatefulWidget with NavigationStates {
  final UserModel userModel;
  Profil({this.userModel});
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String err = "";
  bool _loading = false;
  CustomTextField nameText = new CustomTextField(
      title: "Nom",
      placeholder: "Entrer votre nom"
  );
  void UpdateProfil(String name, String prenom, String email,  String pass)async {
    setState(() {
      _loading = true;
    });

    final response = await http.put(Uri.parse(
        "https://goldene.000webhostapp.com/GoldenElevage/modifier.php"),
        body: {
          "id": UserModel.sessionUser.id.toString(),
          "name":name,
          "prenom":prenom,
          "email":email,
          "pass":pass
        });
    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
      var result = data['data'];
      int succes = result[1];
      if(succes == 1){
        setState(() {
          err = result[0];
          _loading = false;
        });
      }else{
        setState(() {
          err = result[0];
          _loading = false;
        });
      }
    }
  }
  CustomTextField prenomText = new CustomTextField(
      title: "Prénom",
      placeholder: "Entrer votre prénom"
  );
  CustomTextField emailText = new CustomTextField(
      title: "Email",
      placeholder: "Entrer votre email"
  );
  CustomTextField professionText = new CustomTextField(
      title: "Profession",
      placeholder: "Entrer votre profession"
  );

  CustomTextField passText = new CustomTextField(
      title: "Mot de Passe",
      placeholder: "*********",
      ispass: true
  );

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    nameText.err = "Veuillez entrer le nom";
    prenomText.err = "Veuillez entrer le prenom";
    emailText.err = "Veuillez entrer l'e-mail";
    passText.err = "Veuillez entrer le mot de passe";
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _key,
            child: Column(
              children: [
              Center(
              child: Text(
              "Modifier Profile",
              style: TextStyle(color: Colors.green,fontSize: 25, fontWeight: FontWeight.w500),

            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 35,
          ),
          nameText.textFormField(),
          SizedBox(height: 12,),
          prenomText.textFormField(),
          SizedBox(height: 12,),
          emailText.textFormField(),
          SizedBox(height: 12,),
          passText.textFormField(),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Acceuil()));
                },
                child: Text("CANCEL",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.black)),
              ),
              RaisedButton(
                onPressed: () {
                  if(_key.currentState.validate()){

                    UpdateProfil(nameText.value, prenomText.value, emailText.value, passText.value);

                  }
                },
                color: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "SAVE",
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.white),
                ),
              )
            ],
          )
          ],
        ),
            ),
          ),
        ),

    );
  }
}
