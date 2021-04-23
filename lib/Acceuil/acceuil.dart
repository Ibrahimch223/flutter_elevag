import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_elevage/Acceuil/principal.dart';
import 'package:flutter_elevage/Acceuil/sidebar.dart';
import 'package:flutter_elevage/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:flutter_elevage/model/userModel/userModel.dart';

class Acceuil extends StatefulWidget {
final VoidCallback login;
Acceuil({this.login});

  @override
  _AcceuilState createState() => _AcceuilState();
}

void getlogin() {

}

class _AcceuilState extends State<Acceuil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(icon: Icon(Icons.exit_to_app,color:Colors.grey[800],), onPressed: () {
              widget.login.call();
              UserModel.logOut();
            },),
          ),
        ],
      ),
      body: BlocProvider<Navigationbloc>(
        create: (context) => Navigationbloc(),
        child: Stack(
          children: [
            BlocBuilder<Navigationbloc, NavigationStates>(
              builder: (context, navigationStates) {
                return navigationStates as Widget;
              },
            ),
            SideBar(),
          ],
        ),
      ),
    );
  }
}
