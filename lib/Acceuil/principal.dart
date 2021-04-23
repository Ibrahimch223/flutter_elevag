

import 'package:flutter/material.dart';
import 'package:flutter_elevage/Acceuil/data.dart';
import 'package:flutter_elevage/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:flutter_elevage/category_list.dart';

import '../alimentation.dart';




class Principal extends StatefulWidget with NavigationStates{
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {

  Color whiteColor = Colors.white;
  TextStyle style = TextStyle(color: Colors.white);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Golden Elevage",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Rechercher",
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.only(right: 30),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 16, left: 24),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 24,
                    ),
                  )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
              child: Image.asset('assets/acc.JPG'),
            ),
            Padding(
                padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Catégories d'animaux",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildPetCategory(Category.BEEF, Colors.orange[200]),
                        buildPetCategory(Category.SHEEP, Colors.blue[200]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildPetCategory(Category.COCK, Colors.red[200]),
                        buildPetCategory(Category.COW, Colors.green[200]),
                      ],
                    ),
                  ],
                ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Suivi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
            Container(
              height: 130,
              margin: EdgeInsets.only(bottom: 16),
              child: PageView(
                physics: BouncingScrollPhysics(),
                children: [
                  BuildVet("assets/alimentation.jpg", "Alimentation",),
                  buildVet("assets/vaccination.png", "Vaccination"),
                  buildVet("assets/insemination.png", "Insémination")
                ],
              ),
            ),
      ],
    ),
    ),
    );
  }
  Widget buildPetCategory(Category category, Color color){
    return Expanded(
        child: GestureDetector(
          onTap : (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryList(category: category),)
            );
          },
          child: Container(
            height: 80,
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[200],
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.5),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,

                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        category == Category.BEEF ? "Boeufs": category == Category.SHEEP ? "Moutons":
                        category == Category.COCK ? "Poules": "Vaches",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }


  Widget buildVet(String imageUrl, String name){
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 4),
       padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
           Radius.circular(25),
    ),
           border: Border.all(
          width: 1,
          color: Colors.grey[300],
    ),
    ),
    child: Row(
    children: [
      Container(
      height: 98,
      width: 98,
      decoration: BoxDecoration(
      image: DecorationImage(
       image: AssetImage(imageUrl),
       fit: BoxFit.contain,
    ),
    ),
    ),
      SizedBox(
      width: 16,
    ),
    Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Text(
        name,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 12,
          fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ],
    ),
    );
  }

  Widget BuildVet(String imageUrl, String name){
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 4),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 1,
          color: Colors.grey[300],
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 98,
            width: 98,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: FlatButton.icon(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Alimentation()));
                }, icon: Icon(Icons.navigate_next, color: whiteColor,), label: Text("Entrez", style: style,), color: Colors.green),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}