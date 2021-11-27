import 'package:json_annotation/json_annotation.dart';
import 'package:sabilapp/api/Classes/Classes.dart';

class Eleves {
  @JsonKey(name: 'id')
  int id;
  String nom;
  String prenom;
  String username;
  String password;
  String niveau;
  Classes classe;

  Eleves(
      {this.id,
      this.nom,
      this.prenom,
      this.username,
      this.password,
      this.niveau,
      this.classe});

  factory Eleves.fromJson(Map<String, dynamic> json) {
    return Eleves(
        id: json['id'] as int,
        nom: json['nom'] as String,
        prenom: json['prenom'] as String,
        username: json['username'] as String,
        password: json['password'] as String,
        niveau: json['niveau'] as String,
        classe: Classes.fromJson(json['classe'])
        );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "username": username,
        "password": password,
        "niveau": niveau,
        "classe": classe,
      };
}
