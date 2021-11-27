import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:sabilapp/content/cours.dart';

Future<List<Cours>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse('assets/cours.json'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseCours, response.body);
}

List<Cours> parseCours(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Cours>((json) => Cours.fromJson(json)).toList();
}