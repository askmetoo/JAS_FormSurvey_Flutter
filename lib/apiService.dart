import 'dart:convert';
import 'package:jas_survey/models/beritaAcara.dart';
import 'package:http/http.dart' show Client;
import 'package:jas_survey/models/cable.dart';
import 'package:jas_survey/models/deviceComp.dart';

class ApiService {
  final getURLSurvey = "https://jas.dev.usu.ac.id/api/v1/survey/";
  final getURLCable = "https://jas.dev.usu.ac.id/api/v1/cable/";
  final getURLDevice = "https://jas.dev.usu.ac.id/api/v1/device/";
  Client client = Client();

  Future<List<BeritaAcara>> getSurvey() async {
    final response = await client.get("$getURLSurvey");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print(data);
      return List<BeritaAcara>.from(
          data.map((item) => BeritaAcara.fromJson(item)));
    } else {
      return null;
    }
  }

  Future<String> createSurvey(BeritaAcara data) async {
    // print(data.toJson());
    // print(getURL);
    final response = await client.post("$getURLSurvey",
        headers: {"content-type": "application/json"},
        body: json.encode(data.toJson()));
    // print(response.statusCode);
    if (response.statusCode == 201) {
      var result = json.decode(response.body);
      // print(response.reasonPhrase);
      var lastId = result['survey_id'];
      // print(lastId);
      return lastId;
    } else {
      print(response.reasonPhrase);
      return "failed";
    }
  }

  Future<bool> createCable(Cable data) async {
    final response = await client.post("$getURLCable", headers: {"content-type": "application/json"},body: json.encode(data.toJson()));
    print(json.encode(data.toJson()));
    print(response.statusCode);
    if (response.statusCode ==201) {
      return true;
    } else {
      return false;
    }
    // print(json.encode(data));
    
  }

  Future<bool> createDevice(DeviceComp data) async {
    final response = await client.post("$getURLDevice",headers: {"content-type": "application/json"}, body: json.encode(data.toJson()));
    print(json.encode(data.toJson()));
    print(response.statusCode);
    if (response.statusCode ==201) {
      return true;
    } else {
      return false;
    }
  }
}
