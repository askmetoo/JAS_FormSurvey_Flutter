import 'dart:convert';

import 'package:jas_survey/models/cable.dart';
import 'package:jas_survey/models/deviceComp.dart';

class BeritaAcara {
  int id_survey;
  DateTime date;
  String location;
  List<Cable> cablesList;
  List<DeviceComp> deviceList;
  String adminName;
  String adminSign;
  String clientName;
  String clientSign;

  BeritaAcara({this.id_survey, this.date, this.location, this.cablesList, this.deviceList, this.adminName, this.adminSign, this.clientName, this.clientSign});

  factory BeritaAcara.fromJson(Map<String, dynamic> json){
    return BeritaAcara(
      id_survey: int.parse(json['id_survey']),
      date:DateTime.parse(json["date"]),
      location:json['location'],
      // cablesList:List<Cable>.from(json['cable_list'].map((cable) => Cable.fromJson(cable))),
      // deviceList:List<DeviceComp>.from(json['device_list'].map((device) => DeviceComp.fromJson(device))),
      adminName:json['admin_name'],
      adminSign:json['admin_sign'],
      clientName:json['client_name'],
      clientSign:json['client_sign'],
    );
  }

   Map<String, dynamic> toJson() {
    return {
      "id_survey":"",
      "location": location.toString(),
      "date": "${date.year}-${date.month}-${date.day}",
      // "cable_list":cablesList.toJson,
      "admin_name":adminName.toString(),
      "admin_sign": adminSign.toString(),
      "client_name":clientName.toString(),
      "client_sign":clientSign.toString()
    };
  }

  List<BeritaAcara> surveyFromJson(String jsonData){
    final data = json.decode(jsonData);
    return List<BeritaAcara>.from(data.map((item)=>BeritaAcara.fromJson(item)));
  }

  String surveyToJson(BeritaAcara surveyData){
    final jsonData = surveyData.toJson();
    return json.encode(jsonData);
  }
  
}