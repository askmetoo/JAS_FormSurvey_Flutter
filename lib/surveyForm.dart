import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:jas_survey/addComponent/adminSignatureField.dart';
import 'package:jas_survey/addComponent/cableAddForm.dart';
import 'package:jas_survey/addComponent/clientSignatureField.dart';
import 'package:jas_survey/listDevicePage/FiberDeviceListPage.dart';
import 'package:jas_survey/listDevicePage/cableListPage.dart';
import 'package:jas_survey/listDevicePage/switchListPage.dart';
import 'package:jas_survey/listDevicePage/wirelessListPage.dart';

class SurveyForm extends StatefulWidget {
  SurveyForm({Key key}) : super(key: key);

  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  String jenisPerangkat;
  DateTime _date = DateTime.now();
  final formSurvey = GlobalKey<FormState>();
  static var color = Colors.red;
  static var strokeWidth = 5.0;
  String signAdmin;
  String signClient;

  //for signature
  setSignAdmin(String sign) {
    setState(() {
      signAdmin = sign;
    });
  }

  String getAdminSign() {
    return signAdmin;
  }

  setSignClient(String sign) {
    setState(() {
      signClient = sign;
    });
  }

  String getClientSign() {
    return signClient;
  }

  //FOR CABLE PROCESS
  List<Cable> getCables() {
    return cables;
  }

  List<Cable> cables = [];

  addCable(Cable newcable) {
    setState(() {
      cables.add(newcable);
      Navigator.pop(context);
    });
  }

  removeCable(index) {
    print(index);
    setState(() {
      cables.removeAt(index);
    });
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CableListPage(
            addCable: addCable,
            setCable: getCables,
            dataCable: cables,
            removeCable: removeCable))); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                "${_date.day}-${_date.month}-${_date.year}",
                                textAlign: TextAlign.left,
                              )),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.location_on),
                            onPressed: () {},
                          ),
                          title: TextFormField(
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
                                ListTile(
                                  leading: Icon(Icons.device_hub),
                                  title: Text(
                                    'Wireless Device',
                                    style: TextStyle(
                                        fontSize: 17.0, color: Colors.black),
                                  ),
                                  trailing: RaisedButton(
                                    elevation: 0,
                                    color: Theme.of(context).accentColor,
                                    child: Text('Add'),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WirelessListPage()));
                                    },
                                  ),
                                  enabled: false,
                                ),
                                ListTile(
                                  leading: Icon(Icons.device_hub),
                                  title: Text(
                                    'Switch',
                                    style: TextStyle(
                                        fontSize: 17.0, color: Colors.black),
                                  ),
                                  trailing: RaisedButton(
                                    elevation: 0,
                                    color: Theme.of(context).accentColor,
                                    child: Text('Add'),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SwitchListPage()));
                                    },
                                  ),
                                  enabled: false,
                                ),
                                ListTile(
                                  leading: Icon(Icons.device_hub),
                                  title: Text(
                                    'Cable',
                                    style: TextStyle(
                                        fontSize: 17.0, color: Colors.black),
                                  ),
                                  trailing: RaisedButton(
                                    elevation: 0,
                                    color: Theme.of(context).accentColor,
                                    child: Text('Add'),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CableListPage(
                                                      addCable: addCable,
                                                      setCable: getCables,
                                                      dataCable: cables,
                                                      removeCable:
                                                          removeCable)));
                                    },
                                  ),
                                  enabled: false,
                                ),
                                ListTile(
                                  leading: Icon(Icons.device_hub),
                                  title: Text(
                                    'Fiber Device',
                                    style: TextStyle(
                                        fontSize: 17.0, color: Colors.black),
                                  ),
                                  trailing: RaisedButton(
                                    elevation: 0,
                                    color: Theme.of(context).accentColor,
                                    child: Text('Add'),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FiberDeviceListPage()));
                                    },
                                  ),
                                  enabled: false,
                                )
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
                        height: 45.0,
                        color: Theme.of(context).accentColor,
                        minWidth: double.infinity,
                        child: Text(
                          'Sudmit',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                        ),
                        onPressed: () {
                          if (formSurvey.currentState.validate()) {
                            debugPrint('Form Submitted');
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
      initialDate: _date,
      firstDate: new DateTime(2016),
      lastDate: new DateTime(2030),
    );
    if (selectDate != null && selectDate != _date) {
      setState(() {
        _date = selectDate;
      });
    }
  }
}
