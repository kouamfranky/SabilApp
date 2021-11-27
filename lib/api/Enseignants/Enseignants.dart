 
import 'package:json_annotation/json_annotation.dart';
import 'package:sabilapp/api/Classes/Classes.dart';

class Enseignants {
  @JsonKey(name: 'id')
  int id;
  String nom;
  String prenom;
  String username;
  String password; 
  String status;
  String grade;
  List <Classes> classe_Ens; 

  Enseignants({this.id, this.nom, this.prenom, this.username, this.password, this.status, this.grade,this.classe_Ens});

  factory Enseignants.fromJson(Map<String, dynamic> json) {
    return Enseignants(
        id: json['id'] as int,
        nom: json['nom'] as String,
        prenom: json['prenom'] as String,
        username: json['username'] as String,
        password: json['password'] as String,
        status: json['status'] as String,
        grade: json['grade'] as String,
        classe_Ens: json['classe_Ens'] as List <Classes>);
  }
}
