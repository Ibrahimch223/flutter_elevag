import 'package:flutter_elevage/model/userModel/animauxModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elevage/model/userModel/userModel.dart';
import 'package:flutter_elevage/api/api.dart';

class PostUserd extends StatefulWidget {
  @override
  _PostUserdState createState() => _PostUserdState();
}
class _PostUserdState extends State<PostUserd> {

  List<AnimauxModel> animauxModel = [];
  bool isok = false;

  getPostUser()async{
    setState(() {
      isok = false;
    });
    var data = await Api.getPostUser(UserModel.sessionUser.id);
    if(data != null){
      animauxModel.clear();
      setState(() {
        isok = true;
      });
      for(Map i in data){
        setState(() {
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
  List<bool> valueCheck = [];
  List idanimaux = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Supprimer un animal"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: ()async{
             if(idanimaux.length > 0){
               showDialog(context: context,
                 builder:(context){
                    return AlertDialog(
                      title: Text("Supprimer"),
                      content: Text("Voulez-vous supprimer ?"),
                      actions: [
                         FlatButton(onPressed: ()async{
                            var isdelete = await Api.deleteAnimaux(idanimaux);
                            if(isdelete != null){
                              if(isdelete[0]){
                                setState(() {
                                   idanimaux.clear();
                                   Navigator.of(context).pop();
                                   getPostUser();
                                });
                              }
                            }else{
                              Navigator.of(context).pop();
                            }
                          }, child: Text("Oui")),
                        FlatButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Text("Non"))
                      ],
                    );
                 }
                 );
             }
          }),
        ],
      ),
      body: isok? ListView.builder(
        itemCount: animauxModel.length,
        itemBuilder: (context, i){
          final post = animauxModel[i];
          valueCheck.add(false);
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
                    child: Checkbox(
                      value: valueCheck[i],
                      onChanged: (bool value){
                        setState(() {
                           valueCheck[i] = value;
                           if(valueCheck[i]) idanimaux.add(post.id_animaux);
                           else idanimaux.remove(post.id_animaux);
                        });
                      },
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
