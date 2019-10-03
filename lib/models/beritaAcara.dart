import 'package:jas_survey/models/cable.dart';
import 'package:jas_survey/models/deviceComp.dart';

class BeritaAcara {
  DateTime date;
  String location;
  List<Cable> cablesList;
  List<DeviceComp> deviceList;
  String adminName;
  String adminSign;
  String clientName;
  String clientSign;

  BeritaAcara({this.date, this.location, this.cablesList, this.deviceList, this.adminName, this.adminSign, this.clientName, this.clientSign});
}