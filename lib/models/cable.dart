import 'dart:convert';

class Cable {
  int id_cable;
  int id_survey;
  int cable_length;
  String cable_type = "";

  Cable({this.id_cable, this.id_survey, this.cable_length, this.cable_type});

  factory Cable.fromJson(Map<String, dynamic> json) {
    return Cable(
      id_cable: int.parse(json['id_cable']),
      id_survey: int.parse(json['id_survey']),
      cable_type: json['cable_type'],
      cable_length: int.parse(json['cable_length']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_cable": "",
      "id_survey": id_survey,
      "cable_type": cable_type,
      "cable_length": cable_length
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
