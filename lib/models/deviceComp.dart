class DeviceComp {
  int id_device;
  int id_survey;
  String deviceCompType ="";
  String vendor="";
  String asetNum="";
  int jumlah;

  DeviceComp({this.id_device, this.id_survey, this.deviceCompType, this.vendor, this.asetNum, this.jumlah});

  factory DeviceComp.fromJson(Map<String, dynamic> json){
    return DeviceComp(
    id_device: int.parse(json['id_device']),
    id_survey: int.parse(json['id_survey']),
    deviceCompType:json['device_type'],
    vendor:json['device_vendor'],
    asetNum:json['device_assetNumber'],
    jumlah:int.parse(json['device_amount']),
    );}
  
  Map<String, dynamic> toJson(){
    return{
      "id_device":"",
      "id_survey":id_survey,
      "device_type":deviceCompType,
      "device_vendor":vendor,
      "device_assetNumber":asetNum,
      "device_amount":jumlah
    };
  }
}