
import 'package:flutter_elevage/model/userModel/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elevage/widgets/customTextField.dart';
import 'package:flutter_elevage/api/api.dart';
import 'model/userModel/postModel.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}
class _AddPostState extends State<AddPost> {

  @override
  void initState(){
    super.initState();
  }

  CustomTextField nom = new CustomTextField(placeholder: "Entrer le nom de l'aliment", title: "Nom");
  CustomTextField quantite = new CustomTextField(placeholder: "Entrer la quantité de l'aliment", title: "Quantité");
   PostModel myPost = new PostModel();
  bool post = false;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nom.err = "Veuillez entrer le nom";
    quantite.err = "Veuillez entrer la quantité";
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un aliment"),
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
                Text("Nouvel aliment", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 30,
                ),
                nom.textFormField(),
                SizedBox(
                  height: 12,
                ),
                quantite.textFormField(),
                SizedBox(
                  height: 12,
                ),
                RaisedButton(onPressed:post?null:()async{
                  if(_key.currentState.validate()) {
                    setState(() {
                      post = true;
                    });
                    myPost.nom = nom.value;
                    myPost.quantite = quantite.value;
                    myPost.user = UserModel.sessionUser.id;
                    var result = await Api.addPost(myPost.toMap());
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