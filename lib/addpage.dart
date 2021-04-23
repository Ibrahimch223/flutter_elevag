
import 'package:flutter/material.dart';
import 'package:flutter_elevage/widgets/customTextField.dart';
import 'package:flutter_elevage/api/api.dart';
import 'package:flutter_elevage/model/userModel/animauxModel.dart';
import 'package:flutter_elevage/model/userModel/UserModel.dart';

class AppPost extends StatefulWidget {
  @override
  _AppPostState createState() => _AppPostState();
}
class _AppPostState extends State<AppPost> {

  @override
  void initState(){
    super.initState();
  }

  CustomTextField espece = new CustomTextField(placeholder: "Entrer l'espèce", title: "Espèce");
  CustomTextField matricule = new CustomTextField(placeholder: "Entrer le matricule", title: "Matricule");
  AnimauxModel myAnimaux = new AnimauxModel();
  bool post = false;

  final _key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    espece.err = "Veuillez entrer l'espèce";
    matricule.err = "Veuillez entrer le matricule";
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un animal"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Container(
            padding: EdgeInsets.all(10),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(
                     height: 12,
                   ),
                   Text("Nouvel animal", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
                   SizedBox(
                     height: 30,
                   ),
                    espece.textFormField(),
                   SizedBox(
                     height: 12,
                   ),
                   matricule.textFormField(),
                   SizedBox(
                     height: 12,
                   ),
                   RaisedButton(onPressed:post?null:()async{
                     if(_key.currentState.validate()) {
                       setState(() {
                         post = true;
                       });
                       myAnimaux.espece = espece.value;
                       myAnimaux.matricule = matricule.value;
                       myAnimaux.user = UserModel.sessionUser.id;
                       var result = await Api.addAnimaux(myAnimaux.toMap());
                       if(result !=null && result[0]){
                         setState(() {
                           post = false;
                         });
                         Navigator.of(context).pop();
                       }else if(result !=null && !result[0]){
                         setState(() {
                           post = false;
                         });
                       }else{
                         setState(() {
                           post = false;
                         });
                       }
                     }
                   },
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10)
                       ),
                       child: Text("Ajouter", style: TextStyle(color: Colors.white, fontSize: 20),),
                       color: Colors.green.withOpacity(.7)
                   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
 }