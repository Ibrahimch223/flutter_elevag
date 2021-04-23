
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elevage/Acceuil/data.dart';
import 'package:flutter_elevage/deletePage.dart';
import 'package:flutter_elevage/model/userModel/animauxModel.dart';
import 'package:flutter_elevage/Acceuil/pet_widget.dart';
import 'updatePage.dart';
import 'addpage.dart';
import 'api/api.dart';
import 'model/userModel/animauxModel.dart';


class CategoryList extends StatefulWidget {

  final Category category;

  CategoryList({@required this.category});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>{
  Color whiteColor = Colors.white;
  TextStyle style = TextStyle(color: Colors.white);
  get category => null;
  List<AnimauxModel>animauxModel = [];
  getdata()async{
    var data = await Api.getPost();
     if(data != null){
       animauxModel.clear();
       for(Map i in data){
         setState(() {
           animauxModel.add(AnimauxModel.fromJson(i));
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        title: Text(
            (category == Category.BEEF ? "Boeuf" : category == Category.SHEEP ? "Mouton" : category == Category.COCK ? "Poule" : "Vache") + " Catégories",
            style: TextStyle(
              color: Colors.grey[800],
            ),
        ),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AppPost()));
                  }, icon: Icon(Icons.add, color: whiteColor,), label: Text("Ajouter", style: style,), color: Colors.green),
                   FlatButton.icon(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> PostUser()));
                   }, icon: Icon(Icons.edit, color: whiteColor,), label: Text("Modifier", style: style,), color: Colors.yellow),
                   FlatButton.icon(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> PostUserd()));
                   }, icon: Icon(Icons.delete, color: whiteColor,), label: Text("Supprimer", style: style,), color: Colors.red),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height/1.25,
              child: ListView.builder(
                itemCount: animauxModel.length,
                 itemBuilder: (context, i){
                     final animaux = animauxModel[i];
                     return Card(
                       child: Container(
                         padding: EdgeInsets.all(10),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(animaux.espece, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                             Divider(),
                             Text(animaux.matricule)
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

