class ImageSurvey {
  int idImage;
  int idSurvey;
  String imageString;

  ImageSurvey({this.idImage, this.idSurvey, this.imageString});

  factory ImageSurvey.fromJson(Map<String, dynamic> json) {
    return ImageSurvey(
      idImage: int.parse(json['id_image']),
      idSurvey: int.parse(json['id_survey']),
      imageString: json['image_string'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_image": "",
      "id_survey": idSurvey,
      "image_string": imageString,
    };
  }
}
