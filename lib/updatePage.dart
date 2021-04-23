import 'package:flutter_elevage/model/userModel/animauxModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elevage/model/userModel/userModel.dart';
import 'package:flutter_elevage/widgets/customTextField.dart';
import 'package:flutter_elevage/api/api.dart';

class PostUser extends StatefulWidget {
  @override
  _PostUserState createState() => _PostUserState();
}
class _PostUserState extends State<PostUser> {

  List<AnimauxModel> animauxModel = [];
  bool isok = false;

getPostUser()async{
  setState(() {
    isok = false;
  });
  var data = await Api.getPostUser(UserModel.sessionUser.id);
  if(data != null){
    animauxModel.clear();
    for(Map i in data){
      setState(() {
        isok = true;
        animauxModel.add(AnimauxModel.fromJson(i));
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
   getPostUser();
}
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier un animal"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.refresh, color: Colors.white,), onPressed: (){
            getPostUser();
          }),
        ],
      ),
      body: isok? ListView.builder(
        itemCount: animauxModel.length,
        itemBuilder: (context, i){
          final post = animauxModel[i];
          return Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.espece, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Divider(),
                  Text(post.image),
                  Divider(),
                  Text(post.matricule),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.yellow,
                      child: IconButton(icon:Icon(Icons.edit, color: Colors.black,), onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateAnimaux(model: post,)));
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


class UpdateAnimaux extends StatefulWidget {
  AnimauxModel model;
  UpdateAnimaux({this.model});
  @override
  _UpdateAnimauxState createState() => _UpdateAnimauxState();
}
class _UpdateAnimauxState extends State<UpdateAnimaux> {
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
    espece.initialValue = widget.model.espece;
    matricule.initialValue = widget.model.matricule;
    espece.err = "Veuillez entrer l'espèce";
    matricule.err = "Veuillez entrer le matricule";
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier un animal"),
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
                Text("Modifier l'animal", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
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
                    myAnimaux.id_animaux = widget.model.id_animaux;
                    var result = await Api.updateAnimaux(myAnimaux.toMap());
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