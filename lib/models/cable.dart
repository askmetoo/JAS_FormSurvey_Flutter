import 'dart:convert';

class Cable {
  String id_cable="";
  String id_survey="";
  String panjang ="";
  String jenisKabel="";

  Cable({this.id_cable, this.id_survey, this.panjang, this.jenisKabel});

  factory Cable.fromJson(Map<String, dynamic> json){
    return Cable(
      id_cable:json['id_cable'],
      id_survey:json['id_survey'],
      jenisKabel:json['cable_type'],
      panjang:json['cable_length'],    
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "id_cable":id_cable,
      "id_survey":id_survey,
      "jenisKabel":jenisKabel,
      "panjang":panjang
    };
  }

  List<Cable> cableFromJson(String jsonData){
    final data = json.decode(jsonData);
    return List<Cable>.from(data.map((item)=>Cable.fromJson(item)));
  }

   String cableToJson(Cable cableData){
    final jsonData = cableData.toJson();
    return json.encode(jsonData);
  }
}

// List<Cable> cableFromJson(String jsonData){
//     final data = json.decode(jsonData);
//     return List<Cable>.from(data.map((item)=>Cable.fromJson(item)));
//   }