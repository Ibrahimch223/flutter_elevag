import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_elevage/widgets/customTextField.dart';
import 'package:flutter_elevage/widgets/loading.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  final Function visible;
  Register(this.visible);
  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  String err = "";
  bool _loading = false;
  CustomTextField nameText = new CustomTextField(
      title: "Nom",
      placeholder: "Entrer votre nom"
  );
  void register(String name, String prenom, String email, String profession, String pass)async {
    setState(() {
      _loading = true;
    });
    final response = await http.post(
        "https://goldene.000webhostapp.com/GoldenElevage/register.php",
        body: {
          "name":name,
          "prenom":prenom,
          "email":email,
          "profession":profession,
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
  CustomTextField confirmpassText = new CustomTextField(
      title: "Confirmer mot de Passe",
      placeholder: "*********",
      ispass: true
  );
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    nameText.err = "Veuillez entrer le nom";
    prenomText.err = "Veuillez entrer le prenom";
    emailText.err = "Veuillez entrer l'e-mail";
    professionText.err = "Veuillez entrer la profession";
    passText.err = "Veuillez entrer le mot de passe";
    return _loading?Loading():Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Connectez-vous", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green),),
                  SizedBox(height: 30,),
                  nameText.textFormField(),
                  SizedBox(height: 12,),
                  prenomText.textFormField(),
                  SizedBox(height: 12,),
                  emailText.textFormField(),
                  SizedBox(height: 12,),
                  professionText.textFormField(),
                  SizedBox(height: 12,),
                  passText.textFormField(),
                  SizedBox(height: 12,),
                  confirmpassText.textFormField(),
                  SizedBox(height: 12,),
                  RaisedButton(onPressed: (){
                    if(_key.currentState.validate()){
                      if(passText.value == confirmpassText.value){
                        register(nameText.value, prenomText.value, emailText.value, professionText.value, passText.value);}
                      else{
                        print("Les mots de passe sont différents");
                      }
                    }
                  },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("Inscription", style: TextStyle(color: Colors.white, fontSize: 20),),
                      color: Colors.green.withOpacity(.7)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Avez-vous un compte ?',style: TextStyle(fontSize: 12),),
                      FlatButton(onPressed: widget.visible,
                          child: Text("Connectez-vous",
                            style: TextStyle(color: Colors.green),))
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text(err, style: TextStyle(color: Colors.green),textAlign: TextAlign.center,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}