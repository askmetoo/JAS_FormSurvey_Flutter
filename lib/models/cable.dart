import 'dart:convert';

class Cable {
  int idCable;
  int idSurvey;
  int cableLength;
  String cableType = "";

  Cable({this.idCable, this.idSurvey, this.cableLength, this.cableType});

  factory Cable.fromJson(Map<String, dynamic> json) {
    return Cable(
      idCable: int.parse(json['id_cable']),
      idSurvey: int.parse(json['id_survey']),
      cableType: json['cable_type'],
      cableLength: int.parse(json['cable_length']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_cable": "",
      "id_survey": idSurvey,
      "cable_type": cableType,
      "cable_length": cableLength
    };
  }

  List<Cable> cableFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<Cable>.from(data.map((item) => Cable.fromJson(item)));
  }

  String cableToJson(Cable cableData) {
    final jsonData = cableData.toJson();
    return json.encode(jsonData);
  }
}
