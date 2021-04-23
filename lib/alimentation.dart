import 'package:flutter/material.dart';
import 'package:flutter_elevage/updateAliment.dart';
import 'add.dart';
import 'api/api.dart';
import 'deleteAliment.dart';
import 'model/userModel/postModel.dart';

class Alimentation extends StatefulWidget {

  @override
  _AlimentationState createState() => _AlimentationState();
}

class _AlimentationState extends State<Alimentation>{
  Color whiteColor = Colors.white;
  TextStyle style = TextStyle(color: Colors.white);

  List<PostModel>postModel = [];
  getdata()async{
    var data = await Api.getAliment();
    if(data != null){
      postModel.clear();
      for(Map i in data){
        setState(() {
          postModel.add(PostModel.fromJson(i));
        });
      }
    }
  }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Alimentation"),
        actions: [
          IconButton(icon: Icon(Icons.refresh, color: Colors.white,), onPressed: (){
            print("test");
            getdata();
          }),
        ],
      ),
      body : SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                FlatButton.icon(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPost()));
                }, icon: Icon(Icons.add, color: whiteColor,), label: Text("Ajouter", style: style,), color: Colors.green),
                FlatButton.icon(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AlimentUser()));
                }, icon: Icon(Icons.edit, color: whiteColor,), label: Text("Modifier", style: style,), color: Colors.yellow),
                FlatButton.icon(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PostAlimentd()));
                }, icon: Icon(Icons.delete, color: whiteColor,), label: Text("Supprimer", style: style,), color: Colors.red),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height/1.25,
              child: ListView.builder(
                itemCount: postModel.length,
                itemBuilder: (context, i){
                  final post = postModel[i];
                  return Card(
                    color: Colors.green[100],
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.nom, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Divider(),
                          Text(post.quantite),
                          Divider(),
                          Text("Ajouté le:"+post.date_aliment)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}

