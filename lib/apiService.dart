import 'dart:convert';
import 'package:jas_survey/models/beritaAcara.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  final getURL = "https://jas.dev.usu.ac.id/api/v1/survey/";
  Client client = Client();

  Future<List<BeritaAcara>> getSurvey() async{
    final response = await client.get("$getURL");
    if(response.statusCode ==  200){
      final data = json.decode(response.body);
      // print(data);
      return List<BeritaAcara>.from(data.map((item)=>BeritaAcara.fromJson(item)));
    }
    else{
      return null;
    }
  }
  
  Future<bool> createSurvey(BeritaAcara data) async {
    // print(data.toJson());
    print(getURL);
    final response = await client.post(
      "$getURL",
      headers: {"content-type": "application/json"},
      body: json.encode(
        data.toJson()
      )
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      print(response.reasonPhrase);
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}