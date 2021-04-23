import 'package:flutter/material.dart';
import 'package:flutter_elevage/bloc_navigation_bloc/navigation_bloc.dart';

class Statistic extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Statistiques",
        style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),),
    );
  }
}
