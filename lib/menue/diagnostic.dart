import 'package:flutter/material.dart';
import 'package:flutter_elevage/api/api.dart';
import 'package:flutter_elevage/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:flutter_elevage/model/userModel/diagnosticModel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'ajouterPost.dart';



class Diagnostic extends StatefulWidget with NavigationStates{

  @override
  _DiagnosticState createState() => _DiagnosticState();
}


class _DiagnosticState extends State<Diagnostic>{

  List<DiagnosticModel>postModel = [];
  getdata()async{
    var data = await Api.getDiagnostic();
    if(data != null){
      postModel.clear();
      for(Map i in data){
        setState(() {
          postModel.add(DiagnosticModel.fromJson(i));
        });
      }
    }
  }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var initilize = InitializationSettings(android: android,iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initilize,onSelectNotification: onSelectNotification );
    getdata();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;



  Future onSelectNotification(String payload)async{
    if(payload != null){
      debugPrint("Notification :"+ payload);
    }
  }
  Future showNotification() async{
    var android = AndroidNotificationDetails('channelId', 'channelName', 'channelDescription');
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android: android,iOS: ios);
    flutterLocalNotificationsPlugin.show(0, 'title notification', ' body notification', platform,payload: 'seme details values');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text("Résultat du diagnostic"),
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
                FloatingActionButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AjouterPost()));
                }, child: Icon(Icons.add),
                  backgroundColor:  Colors.green,
                ),
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
                          Text(post.matricule, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Divider(),
                          Text(post.diagnostic),
                          Divider(),
                          Text("Traitement:"+post.traitement),
                          Divider(),
                          Text("Enregistré le:"+post.date_diagnostic)
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

