import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_elevage/model/userModel/userModel.dart';
import 'package:flutter_elevage/widgets/customTextField.dart';
import 'package:flutter_elevage/widgets/loading.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  final Function visible, login;
  Login(this.visible, this.login);
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
  String err = "";
  bool _loading = false;
  void login(String email, String pass) async{
    setState(() {
      err = "";
      _loading = true;
    });
    final response = await http.post("https://goldene.000webhostapp.com/GoldenElevage/login.php", body: {
      "email":email,
      "pass":pass
    });
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      var result = data['data'];
      int succes = result[1];
      if(succes == 1){
        setState(() {
          err = result[0];
          UserModel.saveUser(UserModel.fromJson(result[2]));
          _loading = false;
          widget.login.call();
        });
      }else{
        setState(() {
          err = result[0];
          _loading = false;
        });
      }
    }
  }
  CustomTextField emailText = new CustomTextField(
    title: "Email",
    placeholder: "Entrer votre email"
  );
  CustomTextField passText = new CustomTextField(
      title: "Mot de Passe",
      placeholder: "*********",
      ispass: true
  );
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    emailText.err = "Veuillez entrer l'e-mail";
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
                  emailText.textFormField(),
                  SizedBox(height: 12,),
                  passText.textFormField(),
                  SizedBox(height: 12,),
                  RaisedButton(onPressed: ()async{
                    if(_key.currentState.validate()) {
                      login(emailText.value, passText.value);
                    }
                  },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("Connexion", style: TextStyle(color: Colors.white, fontSize: 20),),
                      color: Colors.green.withOpacity(.7)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Avez-vous un compte ?'),
                      FlatButton(
                          onPressed: widget.visible,
                          child: Text(
                            "Inscrivez-vous",
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