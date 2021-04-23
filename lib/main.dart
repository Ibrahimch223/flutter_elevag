import 'package:flutter/material.dart';
import 'package:flutter_elevage/screen/authentification/homePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file:///C:/Users/haida/IdeaProjects/flutter_elevage/lib/Acceuil/principal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


