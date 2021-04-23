
import 'dart:async';
import 'dart:convert';

import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_elevage/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:flutter_elevage/menue/menu-items.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {

  Future<List> getData() async{
    final res= await http.get("https://goldene.000webhostapp.com/GoldenElevage/getuser.php");
    return json.decode(res.body);
  }

  AnimationController _animationController;
  StreamController<bool> SidebarOpenStreamController;
  Stream<bool> SideberOprnStream;
  StreamSink<bool> SideberOprnStreamSink;
  final _animationDuration = const Duration(milliseconds: 500);
  final bool SideBarOpen = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    SidebarOpenStreamController = PublishSubject<bool>();
    SideberOprnStream = SidebarOpenStreamController.stream;
    SideberOprnStreamSink = SidebarOpenStreamController.sink;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    SidebarOpenStreamController.close();
    SideberOprnStreamSink.close();
    super.dispose();

  }

  void onIconPressed(){
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if(isAnimationCompleted){
      SideberOprnStreamSink.add(false);
      _animationController.reverse();
    }else {
      SideberOprnStreamSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: SideberOprnStream,
      builder: (context, isSideBarOpenedAsync) {
        return  AnimatedPositioned(
        duration: _animationDuration,
        top: 0,
        bottom: 0,
        left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
        right: isSideBarOpenedAsync.data ? 0 : screenWidth -35,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.green,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    FutureBuilder<List>(
                      future: getData(),
                      builder: (ctx,ss) {
                        if(ss.hasError){
                          print("Error");
                        }if(ss.hasData){
                          return Items(list:ss.data);
                        }else{
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    Divider(
                      height: 65,
                      thickness: 0.5,
                      color: Colors.white.withOpacity(0.3),
                      indent: 32,
                      endIndent: 32,
                    ),
                    MenuItem(
                      icon: Icons.home,
                      title: "Acceuil",
                      onTap: (){
                        onIconPressed();
                        BlocProvider.of<Navigationbloc>(context).add(NavigationEvents.PrincipalClickEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.person,
                      title: "Modifier Profil",
                      onTap: (){
                        onIconPressed();
                        BlocProvider.of<Navigationbloc>(context).add(NavigationEvents.ProfilClickEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.assessment_outlined,
                      title: "Statistiques",
                      onTap: (){
                        onIconPressed();
                        BlocProvider.of<Navigationbloc>(context).add(NavigationEvents.StatisyiqueClickEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.assignment_outlined,
                      title: "Diagnostic",
                      onTap: (){
                        onIconPressed();
                        BlocProvider.of<Navigationbloc>(context).add(NavigationEvents.DiagnosticClickEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.notifications_active,
                      title: "Notification",
                      onTap: (){
                        onIconPressed();
                        BlocProvider.of<Navigationbloc>(context).add(NavigationEvents.NotificationClickEvent);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.9),
              child: GestureDetector(
                onTap: () {
                  onIconPressed();
                  },
                child: ClipPath(
                  clipper: CustomMenuClipper(),
                  child: Container(
                    width: 35,
                    height: 110,
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    child: AnimatedIcon(
                      progress: _animationController.view,
                      icon: AnimatedIcons.view_list,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        );
      }
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 0, 10, 16);
    path.quadraticBezierTo(width-1, height/2-20, width, height/2);
    path.quadraticBezierTo(width+1, height/2+20, 10, height-16);
    path.quadraticBezierTo(0, height-8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
   return true;
  }

}

class Items extends StatelessWidget {
  List list;
  Items({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list==null?0:list.length,
      itemBuilder: (ctx,i){
        return ListTile(
            title: Text(list[i]['name'],style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w800)),
            subtitle: Text(list[i]['email'],style: TextStyle(color: Colors.greenAccent.withOpacity(0.5),fontSize: 20)),
          leading: CircleAvatar(
            child: Icon(
              Icons.perm_identity,
              color: Colors.white,
            ),
            radius: 40,
          ),
        );

      },
    );
  }
}