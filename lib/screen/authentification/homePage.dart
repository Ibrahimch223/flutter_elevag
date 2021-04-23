import 'package:flutter/material.dart';
import 'package:flutter_elevage/Acceuil/acceuil.dart';
import 'package:flutter_elevage/Acceuil/sidebar.dart';
import 'package:flutter_elevage/menue/profil.dart';
import 'package:flutter_elevage/model/userModel/userModel.dart';
import 'file:///C:/Users/haida/IdeaProjects/flutter_elevage/lib/Acceuil/principal.dart';
import 'package:flutter_elevage/screen/authentification/login.dart';
import 'package:flutter_elevage/screen/authentification/register.dart';
import 'file:///C:/Users/haida/IdeaProjects/flutter_elevage/lib/Acceuil/sidebar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  bool visible = true, login=false;
  isconnected() async{
    await UserModel.getUser();
    if(UserModel.sessionUser == null){
      setState(() {
        login = false;
      });
    }else{
      setState(() {
        login = true;
      });
    }
  }
  toggle(){
    setState(() {
      visible = !visible;
    });
  }
  islogin(){
    setState(() {
      login=!login;
    });
  }
  @override
  void initState(){
    super.initState();
    isconnected();
  }
  @override
  Widget build(BuildContext context) {
    return login?Acceuil(login: islogin):visible? Login(toggle, islogin):Register(toggle);
  }
}