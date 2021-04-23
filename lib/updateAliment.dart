import 'package:flutter/material.dart';
import 'package:flutter_elevage/model/userModel/userModel.dart';
import 'package:flutter_elevage/widgets/customTextField.dart';
import 'package:flutter_elevage/api/api.dart';

import 'model/userModel/postModel.dart';

class AlimentUser extends StatefulWidget {
  @override
  _AlimentUserState createState() => _AlimentUserState();
}
class _AlimentUserState extends State<AlimentUser> {

  List<PostModel> postModel = [];
  bool isok = false;

  getAlimentUser()async{
    setState(() {
      isok = false;
    });
    var data = await Api.getAlimentUser(UserModel.sessionUser.id);
    if(data != null){
      postModel.clear();
      for(Map i in data){
        setState(() {
          isok = true;
          postModel.add(PostModel.fromJson(i));
        });
      }
    }else{
      setState(() {
        isok = true;
      });
    }
  }
  @override
  void initState(){
    super.initState();
    getAlimentUser();
  }
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier un aliment"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.refresh, color: Colors.white,), onPressed: (){
            getAlimentUser();
          }),
        ],
      ),
      body: isok? ListView.builder(
        itemCount: postModel.length,
        itemBuilder: (context, i){
          final post = postModel[i];
          return Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.nom, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Divider(),
                  Text(post.quantite),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.green,
                      child: IconButton(icon:Icon(Icons.edit, color: Colors.black,), onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateAliment(model: post,)));
                      }),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ):Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


class UpdateAliment extends StatefulWidget {
  PostModel model;
  UpdateAliment({this.model});
  @override
  _UpdateAlimentState createState() => _UpdateAlimentState();
}
class _UpdateAlimentState extends State<UpdateAliment> {
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
    nom.initialValue = widget.model.nom;
    quantite.initialValue = widget.model.quantite;
    nom.err = "Veuillez entrer le nom";
    quantite.err = "Veuillez entrer la quantité";
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier un aliment"),
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
                Text("Modifier l'aliment", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
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
                    myPost.id_aliment = widget.model.id_aliment;
                    var result = await Api.updateAliment(myPost.toMap());
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
                    child: Text("Modifier", style: TextStyle(color: Colors.white, fontSize: 20),),
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