import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:sabilapp/api/Classes/Classes.dart';

String CoursToJson(Cours data) => json.encode(data.toJson());

class Cours {
  @JsonKey(name: 'id')
  int id;
  String titre;
  int durree;
  String competence;
  String type;
  String file;
  Classes classe;

  Cours(
      {this.id,
      this.titre,
      this.durree,
      this.competence,
      this.type,
      this.file,
      this.classe});

  factory Cours.fromJson(Map<String, dynamic> json) {
    return Cours(
        id: json['id'] as int,
        titre: json['titre'] as String,
        durree: json['durree'] as int,
        competence: json['competence'] as String,
        type: json['type'] as String,
        file: json['file'] as String,
        classe: Classes.fromJson(json['classe'])
        );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "titre": titre,
        "durree": durree,
        "competence": competence,
        "type": type,
        "file": file,
        "classe": classe,
      };
}
