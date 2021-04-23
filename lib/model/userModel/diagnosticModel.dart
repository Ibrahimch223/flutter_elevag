class DiagnosticModel {
  String matricule;
  String diagnostic, date_diagnostic;
  String traitement;
  String user;
  String id_diagnostic;
  DiagnosticModel({this.matricule, this.diagnostic, this.user, this.traitement, this.id_diagnostic, this.date_diagnostic});

  factory DiagnosticModel.fromJson(Map<String, dynamic> j){
    return DiagnosticModel(
        id_diagnostic: j['id_diagnostic'],
        user: j['id_user'],
        matricule: j['matricule'],
        diagnostic: j['diagnostic'],
        traitement: j['traitement'],
        date_diagnostic: j['date_diagnostic']
    );
  }

  Map toMap(){
    return {
      "id_diagnostic": id_diagnostic,
      "id_user": user,
      "matricule": matricule,
      "diagnostic": diagnostic,
      "traitement": traitement,
      "date_diagnostic": date_diagnostic
    };
  }
}