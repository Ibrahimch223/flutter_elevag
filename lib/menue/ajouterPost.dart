
import 'package:flutter_elevage/model/userModel/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elevage/model/userModel/diagnosticModel.dart';
import 'package:flutter_elevage/widgets/customTextField.dart';
import 'package:flutter_elevage/api/api.dart';



class AjouterPost extends StatefulWidget {
  @override
  _AjouterPostState createState() => _AjouterPostState();
}
class _AjouterPostState extends State<AjouterPost> {

  @override
  void initState(){
    super.initState();
  }

  CustomTextField matricule = new CustomTextField(placeholder: "Entrer le matricule de l'animal", title: "Matricule");
  CustomTextField diagnostic = new CustomTextField(placeholder: "Entrer le diagnostic", title: "Diagnostic", line: 5);
  CustomTextField traitement = new CustomTextField(placeholder: "Entrer le type de traitement", title: "Traitement");
  DiagnosticModel myPost = new DiagnosticModel();
  bool post = false;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    matricule.err = "Veuillez entrer le matricule";
    diagnostic.err = "Veuillez entrer la diagnostic";
    traitement.err = "Veuillez entrer le traitement";
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Fiche médicale"),
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
                matricule.textFormField(),
                SizedBox(
                  height: 12,
                ),
                diagnostic.textFormField(),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 12,
                ),
                traitement.textFormField(),
                SizedBox(
                  height: 12,
                ),
                RaisedButton(onPressed:post?null:()async{
                  if(_key.currentState.validate()) {
                    setState(() {
                      post = true;
                    });
                    myPost.matricule = matricule.value;
                    myPost.diagnostic = diagnostic.value;
                    myPost.traitement = traitement.value;
                    myPost.user = UserModel.sessionUser.id;
                    var result = await Api.ajouterPost(myPost.toMap());
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
                    child: Text("Enregistrer", style: TextStyle(color: Colors.white, fontSize: 20),),
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