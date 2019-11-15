class DeviceComp {
  String deviceCompType ="";
  String vendor="";
  String asetNum="";
  String jumlah="";

  DeviceComp({this.deviceCompType, this.vendor, this.asetNum, this.jumlah});

  factory DeviceComp.fromJson(Map<String, dynamic> json){
    return DeviceComp(
    deviceCompType:json['device_type'],
    vendor:json['device_vendor'],
    asetNum:json['device_assetNumber'],
    jumlah:json['device_amount'],
    );}
}