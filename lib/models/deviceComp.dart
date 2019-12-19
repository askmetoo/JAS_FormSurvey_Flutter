class DeviceComp {
  int idDevice;
  int idSurvey;
  String deviceCompType = "";
  String vendor = "";
  String asetNum = "";
  int jumlah;

  DeviceComp(
      {this.idDevice,
      this.idSurvey,
      this.deviceCompType,
      this.vendor,
      this.asetNum,
      this.jumlah});

  factory DeviceComp.fromJson(Map<String, dynamic> json) {
    return DeviceComp(
      idDevice: int.parse(json['id_device']),
      idSurvey: int.parse(json['id_survey']),
      deviceCompType: json['device_type'],
      vendor: json['device_vendor'],
      asetNum: json['device_assetNumber'],
      jumlah: int.parse(json['device_amount']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_device": "",
      "id_survey": idSurvey,
      "device_type": deviceCompType,
      "device_vendor": vendor,
      "device_assetNumber": asetNum,
      "device_amount": jumlah
    };
  }
}
