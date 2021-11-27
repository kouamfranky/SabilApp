 
import 'package:json_annotation/json_annotation.dart';

class Cours {
  @JsonKey(name: 'id')
  int id;
  String titre;
  int durree;
  String competence;
  String type;
  String file;

  Cours({this.id, this.titre, this.durree, this.competence, this.type, this.file});

  factory Cours.fromJson(Map<String, dynamic> json) {
    return Cours(
        id: json['id'] as int,
        titre: json['titre'] as String,
        durree: json['durree'] as int,
        competence: json['competence'] as String,
        type: json['type'] as String,
        file: json['file'] as String);
  }
   Map<String, dynamic> toJson() => {
        "id": id,
        "titre": titre,
        "durree": durree,
        "competence": competence,
        "type": type,
        "file": file,
      };
}
