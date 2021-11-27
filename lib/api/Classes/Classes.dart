 
import 'package:json_annotation/json_annotation.dart';

class Classes {
  @JsonKey(name: 'id')
  int id;
  String nomClasse; 
  String niveau;

  Classes({this.id, this.nomClasse, this.niveau});
  factory Classes.fromJson(Map<String, dynamic> json) {
    return Classes(
        id: json['id'] as int,
        nomClasse: json['nomClasse'] as String,
         niveau: json['niveau'] as String);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nomClasse": nomClasse,
        "niveau": niveau, 
      };
}
