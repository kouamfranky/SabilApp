 
import 'package:json_annotation/json_annotation.dart';

class Devoirs {
  @JsonKey(name: 'id')
  int id;
  String titre; 
  String file; 

  Devoirs({this.id, this.titre, this.file});

  factory Devoirs.fromJson(Map<String, dynamic> json) {
    return Devoirs(
        id: json['id'] as int,
        titre: json['titre'] as String,
        file: json['file'] as String);
  }
}