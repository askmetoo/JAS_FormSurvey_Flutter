import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jas_survey/addComponent/adminSignatureField.dart';
import 'package:jas_survey/apiService.dart';
import 'package:jas_survey/formComponent/cableComponent.dart';
import 'package:jas_survey/formComponent/deviceComponent.dart';
import 'package:jas_survey/addComponent/clientSignatureField.dart';
import 'package:jas_survey/homeJAS.dart';
import 'package:jas_survey/models/beritaAcara.dart';
import 'package:jas_survey/models/deviceComp.dart';
import 'models/cable.dart';

class SurveyForm extends StatefulWidget {
  SurveyForm({Key key}) : super(key: key);

  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  ApiService _apiService = ApiService();

  BeritaAcara surveyData = new BeritaAcara();

  DateTime date = DateTime.now();
  final formSurvey = GlobalKey<FormState>();
  final _surveyState = GlobalKey<ScaffoldState>();

  String _activityTypeValue;

  String location;
  String diagnosis;
  String solution;
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

  void _failAdd() {
    _surveyState.currentState.showSnackBar(
      SnackBar(content: Text('Failed to add survey')),
    );
  }

  // ADD SURVEY TO DATABASE
  newSurvey(BeritaAcara newData) {
    String locationData = newData.location;
    String clientNameData = newData.clientName;
    String adminNameData = newData.adminName;
    DateTime dateData = newData.date;
    String adminSignData = newData.adminSign;
    String clientSignData = newData.clientSign;
    String actTypeData = newData.actType;
    String diagnosisData = newData.diagnosis;
    String solutionData = newData.solution;

    List<DeviceComp> deviceListData = newData.deviceList;
    List<Cable> cableListData = newData.cablesList;

    BeritaAcara survey = BeritaAcara(
        location: locationData,
        actType: actTypeData,
        diagnosis: diagnosisData,
        solution: solutionData,
        adminName: adminNameData,
        clientName: clientNameData,
        date: dateData,
        adminSign: adminSignData,
        clientSign: clientSignData);

    _apiService.createSurvey(survey).then((idSurvey) {
      if (idSurvey != "failed") {
        // insert cables
        if (cableListData != null) {
          for (var i = 0; i < cableListData.length; i++) {
            cableListData[i].id_survey = int.parse(idSurvey);
            Cable cable = Cable(
                id_survey: int.parse(idSurvey),
                cable_type: cableListData[i].cable_type,
                cable_length: cableListData[i].cable_length);
            _apiService.createCable(cable).then((isSuccess) {
              print("sukses insert cable");
            });
          }
        }
        // insert devices
        if (deviceListData != null) {
          for (var i = 0; i < deviceListData.length; i++) {
            deviceListData[i].id_survey = int.parse(idSurvey);
            DeviceComp device = DeviceComp(
                id_survey: int.parse(idSurvey),
                deviceCompType: deviceListData[i].deviceCompType,
                vendor: deviceListData[i].vendor,
                asetNum: deviceListData[i].asetNum,
                jumlah: deviceListData[i].jumlah);
            _apiService.createDevice(device).then((onValue) {
              print("sukses insert device");
            });
          }
        }
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeJAS()),
            ModalRoute.withName(''));
      } else {
        _failAdd();
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
      print(surveyData.adminSign.length);
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
    setState(() {
      date = date;
      surveyData.date = date;
    });
    return Scaffold(
      key: _surveyState,
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
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.event_note),
                            onPressed: () {},
                          ),
                          key: Key('actType'),
                          title: FormField<String>(
                            validator: (value) {
                              if (value == null) {
                                setState(() {
                                  _activityTypeValue =
                                      "Please Choose Activity Type!";
                                });
                              }
                            },
                            builder: (FormFieldState<String> state) {
                              return DropdownButton<String>(
                                isExpanded: true,
                                hint: Text('Activity Type!'),
                                value: surveyData.actType,
                                onChanged: (String newvalue) {
                                  setState(() {
                                    surveyData.actType = newvalue;
                                    _activityTypeValue = null;
                                  });
                                },
                                items: <String>[
                                  'Network / Device Checking',
                                  'Network / Device Installation',
                                  'Network / Device De-Installation',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                        _activityTypeValue == null
                            ? SizedBox.shrink()
                            : Text(
                                _activityTypeValue ?? "",
                                style: TextStyle(color: Colors.red),
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

                  //DIAGNOSIS AND SOLUTION
                  Card(
                    elevation: 2.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AppBar(
                          leading: Icon(Icons.library_books),
                          elevation: 0,
                          title: Text("Problem and Solution"),
                          backgroundColor: Theme.of(context).accentColor,
                          centerTitle: false,
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.event_note),
                            onPressed: () {},
                          ),
                          title: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                diagnosis = value;
                                surveyData.diagnosis = value;
                              });
                            },
                            key: Key('keyDiagnosis'),
                            decoration: InputDecoration(
                              labelText: 'Diagnosis',
                              hintText: 'type diagnosis / problem',
                              isDense: true,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.playlist_add_check),
                            onPressed: () {},
                          ),
                          title: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                solution = value;
                                surveyData.solution = value;
                              });
                            },
                            key: Key('keySolution'),
                            decoration: InputDecoration(
                              labelText: 'Solution',
                              hintText: 'type the solution',
                              isDense: true,
                            ),
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
