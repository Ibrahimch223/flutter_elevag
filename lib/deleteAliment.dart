import 'package:flutter/material.dart';
import 'package:flutter_elevage/model/userModel/userModel.dart';
import 'package:flutter_elevage/api/api.dart';

import 'model/userModel/postModel.dart';

class PostAlimentd extends StatefulWidget {
  @override
  _PostAlimentdState createState() => _PostAlimentdState();
}
class _PostAlimentdState extends State<PostAlimentd> {

  List<PostModel> postModel = [];
  bool isok = false;

  getAlimentUser()async{
    setState(() {
      isok = false;
    });
    var data = await Api.getAlimentUser(UserModel.sessionUser.id);
    if(data != null){
      postModel.clear();
      setState(() {
        isok = true;
      });
      for(Map i in data){
        setState(() {
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
  List<bool> valueCheck = [];
  List idposts = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Supprimer un aliment"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: ()async{
            if(idposts.length > 0){
              showDialog(context: context,
                  builder:(context){
                    return AlertDialog(
                      title: Text("Supprimer"),
                      content: Text("Voulez-vous supprimer ?"),
                      actions: [
                        FlatButton(onPressed: ()async{
                          var isdelete = await Api.deleteAliment(idposts);
                          if(isdelete != null){
                            if(isdelete[0]){
                              setState(() {
                                idposts.clear();
                                Navigator.of(context).pop();
                                getAlimentUser();
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
        itemCount: postModel.length,
        itemBuilder: (context, i){
          final post = postModel[i];
          valueCheck.add(false);
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
                    child: Checkbox(
                      value: valueCheck[i],
                      onChanged: (bool value){
                        setState(() {
                          valueCheck[i] = value;
                          if(valueCheck[i]) idposts.add(post.id_aliment);
                          else idposts.remove(post.id_aliment);
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
