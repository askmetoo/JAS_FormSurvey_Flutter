class ImageSurvey {
  int id_image;
  int id_survey;
  String image_string;

  ImageSurvey({this.id_image, this.id_survey, this.image_string});

  factory ImageSurvey.fromJson(Map<String, dynamic> json) {
    return ImageSurvey(
      id_image: int.parse(json['id_image']),
      id_survey: int.parse(json['id_survey']),
      image_string: json['image_string'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_image": "",
      "id_survey": id_survey,
      "image_string": image_string,
    };
  }
}