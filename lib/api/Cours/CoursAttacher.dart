 
import 'package:json_annotation/json_annotation.dart';

class CoursAttacher {
  @JsonKey(name: 'id')
  int id;
  String niveau;
  String classe; 
  String type;
  String file;

  CoursAttacher({this.id, this.niveau, this.classe, this.type, this.file});

  factory CoursAttacher.fromJson(Map<String, dynamic> json) {
    return CoursAttacher(
        id: json['id'] as int,
        niveau: json['niveau'] as String,
        classe: json['classe'] as String, 
        type: json['type'] as String,
        file: json['file'] as String);
  }
}
