import 'dart:convert';
import 'package:jas_survey/models/beritaAcara.dart';
import 'package:http/http.dart' show Client;
import 'package:jas_survey/models/cable.dart';
import 'package:jas_survey/models/deviceComp.dart';
import 'package:jas_survey/models/imageSurvey.dart';

class ApiService {
  final getURLSurvey = "https://jas.dev.usu.ac.id/api/v1/survey";
  final getURLCable = "https://jas.dev.usu.ac.id/api/v1/cable";
  final getURLDevice = "https://jas.dev.usu.ac.id/api/v1/device";
  final getURLImage = "https://jas.dev.usu.ac.id/api/v1/imageSurvey";
  Client client = Client();

  Future<List<BeritaAcara>> getSurvey() async {
    final response = await client.get("$getURLSurvey/");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<BeritaAcara>.from(
          data.map((item) => BeritaAcara.fromJson(item)));
    } else {
      return null;
    }
  }

  Future<List<BeritaAcara>> geSurveybyIdSurvey(idSurvey) async {
    final response = await client.get("$getURLSurvey/");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<BeritaAcara>.from(
          data.map((item) => BeritaAcara.fromJson(item)));
    } else {
      return null;
    }
  }

  Future<List<Cable>> geCablebyIdSurvey(idSurvey) async {
    final response =
        await client.get("$getURLCable?id_survey=" + idSurvey.toString());
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 200) {
        return List<Cable>.from(
            data['payload'].map((item) => Cable.fromJson(item)));
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<DeviceComp>> geDevicebyIdSurvey(idSurvey) async {
    final response =
        await client.get("$getURLDevice?id_survey=" + idSurvey.toString());
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 200) {
        return List<DeviceComp>.from(
            data['payload'].map((item) => DeviceComp.fromJson(item)));
      }
    } else {
      return null;
    }
  }

  Future<List<ImageSurvey>> getImage(idSurvey) async{
    // print("$getURLImage?id_survey"+idSurvey.toString());
    final response = await client.get("$getURLImage?id_survey="+idSurvey.toString());
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      // print(data);
      if(data['status']==200){
        return List<ImageSurvey>.from(data['payload'].map((item)=> ImageSurvey.fromJson(item)));
      }
    }
    else{
      return null;
    }
  }

  Future<String> createSurvey(BeritaAcara data) async {
    final response = await client.post("$getURLSurvey/",
        headers: {"content-type": "application/json"},
        body: json.encode(data.toJson()));
    if (response.statusCode == 201) {
      var result = json.decode(response.body);
      var lastId = result['survey_id'];
      return lastId;
    } else {
      // print(response.reasonPhrase);
      return "failed";
    }
  }

  Future<bool> createCable(Cable data) async {
    final response = await client.post("$getURLCable/",
        headers: {"content-type": "application/json"},
        body: json.encode(data.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createDevice(DeviceComp data) async {
    final response = await client.post("$getURLDevice/",
        headers: {"content-type": "application/json"},
        body: json.encode(data.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createImage(ImageSurvey data) async {
    // print(json.encode(data.toJson()));
    final response = await client.post("$getURLImage/",
        headers: {"content-type": "application/json"},
        body: json.encode(data.toJson()));
    if(response.statusCode ==201){
      return true;
    }
    else{
      return false;
    }
  }
}
