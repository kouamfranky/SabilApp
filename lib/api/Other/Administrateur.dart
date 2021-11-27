 
import 'package:json_annotation/json_annotation.dart';

class Administrateur {
  @JsonKey(name: 'id')
  int id;
  String nom;
  String prenom;
  String username;
  String password;  

  Administrateur({this.id, this.nom, this.prenom, this.username, this.password});

  factory Administrateur.fromJson(Map<String, dynamic> json) {
    return Administrateur(
        id: json['id'] as int,
        nom: json['nom'] as String,
        prenom: json['prenom'] as String,
        username: json['username'] as String,
        password: json['password'] as String);
  }
}
