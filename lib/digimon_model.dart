// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Digimon {
  final String name;
  String? imageUrl;
  String? apiname;
  String? levelDigimon;

  int rating = 10;

  Digimon(this.name);

 // digimon_model.dart
String get formattedName {
    return name
        .replaceAll('_', ' ')             
        .replaceAll('(motociclista)', '') 
        .trim();
  }

Future getImageUrl() async {
  if (imageUrl != null) {
    return;
  }

  HttpClient http = HttpClient();
  try {
 
    apiname = name; 

    var uri = Uri.https('es.wikipedia.org', '/api/rest_v1/page/summary/$apiname');
    
    var request = await http.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();

    Map<String, dynamic> data = json.decode(responseBody);

    if (data.containsKey('originalimage')) {
      imageUrl = data['originalimage']['source'];
    } else {
      imageUrl = "https://cdn-icons-png.flaticon.com/512/1077/1077012.png"; 
    }

    levelDigimon = data['description'] ?? "Piloto profesional";

  } catch (exception) {
    print(exception);
    
    imageUrl = "https://cdn-icons-png.flaticon.com/512/1077/1077012.png"; 
  }
}
}

