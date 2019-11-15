import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jas_survey/addComponent/adminSignatureField.dart';
import 'package:jas_survey/apiService.dart';
import 'package:jas_survey/drawer.dart';
import 'package:jas_survey/formComponent/cableComponent.dart';
import 'package:jas_survey/formComponent/deviceComponent.dart';
import 'package:jas_survey/addComponent/clientSignatureField.dart';
import 'package:jas_survey/homeJAS.dart';
import 'package:jas_survey/models/beritaAcara.dart';
import 'package:jas_survey/models/deviceComp.dart';
import 'package:jas_survey/scanForm.dart';

import 'models/cable.dart';

class SurveyForm extends StatefulWidget {
  SurveyForm({Key key}) : super(key: key);

  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  ApiService _apiService = ApiService();

  List<BeritaAcara> listSurvey = [];

  BeritaAcara surveyData = new BeritaAcara();
  DateTime date = DateTime.now();
  final formSurvey = GlobalKey<FormState>();

  String location;
  String signAdmin;
  String adminName;
  String clientName;
  String signClient;

  void _removeDialog(message) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(message),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              )
            ],
          );
        });
  }

  // for add survey into list
  addSurvey(BeritaAcara newSurvey){
    setState(() {
     listSurvey.add(newSurvey); 
    });
    // debugPrint("jumlah survey: "+listSurvey.length.toString());
  }

  newSurvey(BeritaAcara newData){
    String locationData = newData.location;
    String clientNameData = newData.clientName;
    String adminNameData = newData.adminName;
    DateTime dateData = newData.date;
    // String adminSignData = newData.adminSign;
    
    // print(locationData+", "+clientNameData+", "+adminNameData+", ${dateData.year}-${dateData.month}-${dateData.day}");

    // print(adminSignData);
    BeritaAcara survey = BeritaAcara(location: locationData, adminName: adminNameData, clientName: clientNameData, date: dateData, adminSign: "tanda tangan admin", clientSign: "tanda tangan client");
    _apiService.createSurvey(survey).then((isSuccess){
      if(isSuccess){
        print('sukses nambah data');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomeJAS()
        ));
      }
      else{
        print("gagal");
      }
    });
  }

  //For get DeviceList
  List<DeviceComp> deviceComps = [];
  List<DeviceComp> getDevices() {
    return deviceComps;
  }

  setDeviceList(List<DeviceComp> deviceComps) {
    setState(() {
      surveyData.deviceList = deviceComps;
    });
  }

  addDevice(DeviceComp newDevice) {
    setState(() {
      deviceComps.add(newDevice);
      Navigator.pop(context);
    });
  }

  removeDevice(index) {
    // print(index);
    setState(() {
      deviceComps.removeAt(index);
    });
    _removeDialog('Device removed!');
  }

  //For get CableList
  List<Cable> cables = [];
  List<Cable> getCables() {
    return cables;
  }

  setCableList(List<Cable> cables) {
    setState(() {
      surveyData.cablesList = cables;
    });
  }

  addCable(Cable newCable) {
    setState(() {
      cables.add(newCable);
      Navigator.pop(context);
    });
  }

  removeCable(index) {
    setState(() {
      cables.removeAt(index);
    });
    _removeDialog("Cable removed!");
  }

  //for signature
  setSignAdmin(String sign) {
    setState(() {
      signAdmin = sign;
      surveyData.adminSign = sign.toString();
    });
  }

  String getAdminSign() {
    return signAdmin;
  }

  setSignClient(String sign) {
    setState(() {
      signClient = sign;
      surveyData.clientSign = sign.toString();
    });
  }

  String getClientSign() {
    return signClient;
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("jumlah survey: "+listSurvey.length.toString());
    setState(() {
      date = date;
      surveyData.date = date;
    });
    // surveyData.cablesList == null ?
    // debugPrint("surveyData.cableList is empty/null"):
    // debugPrint(surveyData.cablesList.length.toString());
    // surveyData.deviceList == null ?
    // debugPrint("surveyData.deviceList is empty/null"):
    // debugPrint(surveyData.deviceList.length.toString());
    // debugPrint("total kabel: "+ cables.length.toString());
    // debugPrint("total device: "+ deviceComps.length.toString());
    // print(getCableList());
    return Scaffold(
      drawer: Drawer(
        key: Key("drawerBtn"),
        child: DrawerUI(),
      ),
      key: Key('FormKey'),
      appBar: AppBar(
        title: Text('Form Berita Acara'),
        elevation: 2.0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFF90FFC9),
            Color(0xFF80CBc4),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: ListView(
          padding:
              EdgeInsets.only(top: 3.0, right: 3.0, left: 3.0, bottom: 3.0),
          children: <Widget>[
            Form(
              key: formSurvey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //Date and Location Field
                  Card(
                    elevation: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AppBar(
                          leading: Icon(Icons.library_books),
                          elevation: 0,
                          title: Text('Time and Location'),
                          backgroundColor: Theme.of(context).accentColor,
                          centerTitle: false,
                        ),
                        FlatButton(
                          key: Key('KeyDateModal'),
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: ListTile(
                              key: Key('keyDateField'),
                              leading: Icon(Icons.date_range),
                              trailing: Icon(Icons.edit),
                              title: Text(
                                "${date.day}-${date.month}-${date.year}",
                                textAlign: TextAlign.left,
                              )),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.location_on),
                            onPressed: () {},
                          ),
                          title: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                location = value;
                                surveyData.location = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Location Cannot be Empty!';
                              }
                            },
                            key: Key('keyLocation'),
                            decoration: InputDecoration(
                              labelText: 'Location',
                              hintText: 'type the location',
                              isDense: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                  ),

                  //ADD COMPONENTS
                  Card(
                    elevation: 2.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AppBar(
                          leading: Icon(Icons.library_books),
                          elevation: 0,
                          title: Text("Devices and Components"),
                          backgroundColor: Theme.of(context).accentColor,
                          centerTitle: false,
                        ),
                        Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Column(
                              children: <Widget>[
                                DeviceComponent(
                                  addDevice: addDevice,
                                  getDevices: getDevices,
                                  removeDevice: removeDevice,
                                  deviceComps: deviceComps,
                                  setDeviceList: setDeviceList,
                                  // getDeviceList: getDeviceList,
                                ),
                                CableComponent(
                                  addCable: addCable,
                                  getCables: getCables,
                                  removeCable: removeCable,
                                  cables: cables,
                                  setCableList: setCableList,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                  ),

                  //SIGNATURE FIELD
                  Card(
                    elevation: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AppBar(
                          leading: Icon(Icons.verified_user),
                          elevation: 0,
                          title: Text('Verification'),
                          backgroundColor: Theme.of(context).accentColor,
                          centerTitle: false,
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.person),
                            onPressed: () {},
                          ),
                          title: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                adminName = value;
                                surveyData.adminName = value;
                              });
                            },
                            key: Key('keyAdminName'),
                            decoration: InputDecoration(
                              labelText: 'Admin Name',
                              hintText: 'type admin name',
                              isDense: true,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Admin Name Cannot be Empty!';
                              }
                            },
                          ),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.border_color),
                            onPressed: () {},
                          ),
                          title: Text('Admin Signature'),
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminSignField(
                                      setSign: setSignAdmin,
                                      getSign: getAdminSign),
                                ));
                          },
                          trailing: signAdmin == null
                              ? Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.grey,
                                  size: 30.0,
                                )
                              : Icon(
                                  Icons.check_box,
                                  color: Colors.green,
                                  size: 30.0,
                                ),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.person),
                            onPressed: () {},
                          ),
                          title: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                clientName = value;
                                surveyData.clientName = value;
                              });
                            },
                            key: Key('keyClientName'),
                            decoration: InputDecoration(
                              labelText: 'Client Name',
                              hintText: 'type client name',
                              isDense: true,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Client Name Cannot be Empty!';
                              }
                            },
                          ),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.border_color),
                            onPressed: () {},
                          ),
                          title: Text('Client Signature'),
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientSginField(
                                    getSign: getClientSign,
                                    setSign: setSignClient,
                                  ),
                                ));
                          },
                          trailing: signClient == null
                              ? Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.grey,
                                  size: 30.0,
                                )
                              : Icon(
                                  Icons.check_box,
                                  color: Colors.green,
                                  size: 30.0,
                                ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                  ),

                  Container(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 15.0, right: 15.0, bottom: 10.0),
                      child: MaterialButton(
                        key: Key('submitFormBtn'),
                        height: 45.0,
                        color: Theme.of(context).accentColor,
                        minWidth: double.infinity,
                        child: Text(
                          'Submit',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                        ),
                        onPressed: () async {
                          if (formSurvey.currentState.validate()) {
                            newSurvey(surveyData);
                            addSurvey(surveyData);
                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return CupertinoAlertDialog(
                            //         content: SingleChildScrollView(
                            //           child: Column(
                            //             children: <Widget>[
                            //               Text("date: ${surveyData.date.day}-${surveyData.date.month}-${surveyData.date.year}"),
                            //               Text("location: " +
                            //                   surveyData.location),
                            //               Text("admin Name: " +
                            //                   surveyData.adminName),
                            //               Text("admin Singature: " +
                            //                   surveyData.adminSign
                            //                       .substring(0, 10)),
                            //               Text("client name: " +
                            //                   surveyData.clientName),
                            //               Text("client signature: " +
                            //                   surveyData.clientSign
                            //                       .substring(0, 10)),
                            //               surveyData.cablesList == null ?
                            //               Text("jumlah jenis kabel 0"):
                            //               Text("jumlah jenis kabel: " +
                            //                   surveyData.cablesList.length
                            //                       .toString()),
                            //               surveyData.deviceList == null?
                            //               Text("jumlah jenis device 0"):
                            //               Text("jumlah jenis device: " +
                            //                   surveyData.deviceList.length
                            //                       .toString()),
                            //             ],
                            //           ),
                            //         ),
                            //         actions: <Widget>[
                            //           MaterialButton(
                            //             onPressed: () async {

                            //               Navigator.push(
                            //                   context,
                            //                   MaterialPageRoute(
                            //                       builder: (context) =>
                            //                           HomeJAS()
                            //                   )
                            //               );
                            //               // Navigator.pop(context);
                            //             },
                            //             child: Text('Close'),
                            //           )
                            //         ],
                            //       );
                            //     });

                            // print(
                            //   surveyData.date.toString()+
                            //     // "${surveyData.date.day}-${surveyData.date.month}-${surveyData.date.year}" +
                            //         surveyData.location +
                            //         surveyData.adminName +
                            //         surveyData.clientName);
                            // print(surveyData.adminSign
                            //         .toString()
                            //         .substring(0, 10) +
                            //     surveyData.clientSign.toString());
                            // surveyData.cablesList == null ?
                            // print("cable list null"):print("cable list total are : "+surveyData.cablesList.length.toString());
                            // surveyData.deviceList == null ?
                            // print("device list null"):print("device list total are : "+surveyData.deviceList.length.toString());
                          }
                        },
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //WIDGET ARE HERE

  //Calender Dialog
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime selectDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: new DateTime(2016),
      lastDate: new DateTime(2030),
    );
    if (selectDate != null) {
      setState(() {
        date = selectDate;
        surveyData.date = selectDate;
      });
    }
  }
}
