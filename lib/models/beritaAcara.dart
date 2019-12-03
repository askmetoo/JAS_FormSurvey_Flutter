import 'dart:convert';

import 'package:jas_survey/models/cable.dart';
import 'package:jas_survey/models/deviceComp.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class BeritaAcara {
  int id_survey;
  DateTime date;
  String location;
  String actType;
  String diagnosis;
  String solution;
  List<Cable> cablesList;
  List<DeviceComp> deviceList;
  List<Asset> imageList;
  String adminName;
  String adminSign;
  String clientName;
  String clientSign;

  BeritaAcara(
      {this.id_survey,
      this.date,
      this.location,
      this.actType,
      this.diagnosis,
      this.solution,
      this.cablesList,
      this.deviceList,
      this.imageList,
      this.adminName,
      this.adminSign,
      this.clientName,
      this.clientSign});

  factory BeritaAcara.fromJson(Map<String, dynamic> json) {
    return BeritaAcara(
      id_survey: int.parse(json['id_survey']),
      date: DateTime.parse(json["date"]),
      location: json['location'],
      actType: json['act_type'],
      diagnosis: json['diagnosis'],
      solution: json['solution'],
      adminName: json['admin_name'],
      adminSign: json['admin_sign'],
      clientName: json['client_name'],
      clientSign: json['client_sign'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_survey": "",
      "location": location.toString(),
      "date": "${date.year}-${date.month}-${date.day}",
      "act_type": actType.toString(),
      "diagnosis": diagnosis.toString(),
      "solution": solution.toString(),
      "admin_name": adminName.toString(),
      "admin_sign": adminSign.toString(),
      "client_name": clientName.toString(),
      "client_sign": clientSign.toString()
    };
  }

  List<BeritaAcara> surveyFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<BeritaAcara>.from(
        data.map((item) => BeritaAcara.fromJson(item)));
  }

  String surveyToJson(BeritaAcara surveyData) {
    final jsonData = surveyData.toJson();
    return json.encode(jsonData);
  }
}
