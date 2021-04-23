import 'package:bloc/bloc.dart';
import 'package:flutter_elevage/Acceuil/principal.dart';
import 'package:flutter_elevage/menue/diagnostic.dart';
import 'package:flutter_elevage/menue/notification.dart';
import 'package:flutter_elevage/menue/profil.dart';
import 'package:flutter_elevage/menue/statistiques.dart';

enum NavigationEvents {
  PrincipalClickEvent,
  ProfilClickEvent,
  StatisyiqueClickEvent,
  DiagnosticClickEvent,
  NotificationClickEvent
}

abstract class NavigationStates {}

class Navigationbloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  // TODO: implement initialState
  NavigationStates get initialState => Principal();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async*{
    switch (event) {
      case NavigationEvents.PrincipalClickEvent:
        yield Principal();
        break;
      case NavigationEvents.ProfilClickEvent:
        yield Profil();
        break;
      case NavigationEvents.DiagnosticClickEvent:
        yield Diagnostic();
        break;
      case NavigationEvents.StatisyiqueClickEvent:
        yield Statistic();
        break;
      case NavigationEvents.NotificationClickEvent:
        yield Notification();
        break;
    }

  }
}