// import 'dart:convert';
// import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

// import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:jas_survey/addComponent/adminSignatureField.dart';
import 'package:jas_survey/addComponent/clientSignatureField.dart';
import 'package:jas_survey/listDevicePage/FiberDeviceListPage.dart';
import 'package:jas_survey/listDevicePage/cableListPage.dart';
import 'package:jas_survey/listDevicePage/switchListPage.dart';
import 'package:jas_survey/listDevicePage/wirelessListPage.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

  ByteData _imgAdminByte = new ByteData(0);

  String signAdmin;
  String signClient;

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
                                                  CableListPage()));
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
                          ),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.border_color),
                            onPressed: () {},
                          ),
                          title: Text('Admin Signature'),
                          onTap: () async {
                            final data = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminSignField(setSign: setSignAdmin, getSign: getAdminSign),
                                ));
                            // if (data != null) {
                            //   final signAdm =
                            //       base64.encode(data.buffer.asUint8List());
                            //   setState(() {
                            //     _signAdmin = signAdm;
                            //   });
                            // }
                            // debugPrint(_signAdmin);
                            // _adminSignField();
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
                          ),
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.border_color),
                            onPressed: () {},
                          ),
                          title: Text('Client Signature'),
                          onTap: () async {
                            final data = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientSginField(getSign: getClientSign, setSign: setSignClient,),
                                ));
                            // final data = await Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => AdminSginField(),
                            //     ));
                            // if (data != null) {
                            //   final signClient =
                            //       base64.encode(data.buffer.asUint8List());
                            //   setState(() {
                            //     _signClient = signClient;
                            //   }
                            //   );
                            // }
                            // _clientSignField();
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
            //Show Signature Result
            // Card(
            //   elevation: 1.0,
            //   child: Column(
            //     children: <Widget>[
            //       _imgAdmin.buffer.lengthInBytes == 0
            //           ? Container()
            //           : LimitedBox(
            //               maxHeight: 200.0,
            //               child: Image.memory(_imgAdmin.buffer
            //                   .asUint8List())), //to show image after click save button
            //       _imgClient.buffer.lengthInBytes == 0
            //           ? Container()
            //           : LimitedBox(
            //               maxHeight: 200.0,
            //               child: Image.memory(_imgClient.buffer
            //                   .asUint8List())), //to show image after click save button
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  //FUNCTION AND WIDGET ARE HERE

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

  // void _adminSignField() {
  //   AlertDialog adminSignField = new AlertDialog(
  //     content: Container(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           AppBar(
  //             leading: Icon(Icons.edit),
  //             elevation: 0,
  //             title: Text('Admin Signature'),
  //             backgroundColor: Theme.of(context).accentColor,
  //             centerTitle: false,
  //           ),
  //           Padding(padding: EdgeInsets.only(bottom: 3.0)),
  //           Container(
  //             width: 350.0,
  //             height: 300.0,
  //             child: Signature(
  //               color: color,
  //               key: _signAdmin,
  //               onSign: () {
  //                 final sign = _signAdmin.currentState;
  //                 debugPrint('${sign.points.length} points in the signature');
  //               },
  //               strokeWidth: strokeWidth,
  //             ),
  //             color: Colors.black12,
  //           ),
  //         ],
  //       ),
  //     ),
  //     actions: <Widget>[
  //       FlatButton(
  //         onPressed: () async {
  //           //retrieve image data, do whatever you want with it (send to server, save locally...)
  //           final sign = _signAdmin.currentState;
  //           final image = await sign.getData();

  //           // convert image into byteData and Base64
  //           var data = await image.toByteData(format: ui.ImageByteFormat.png);
  //           final encoded =
  //               base64.encode(data.buffer.asUint8List()); //encode into base64

  //           setState(() {
  //             _imgAdmin = ByteData(1);
  //           });
  //           // debugPrint("onPressed " + encoded);
  //           debugPrint("Admin Signature retrieved!");

  //           Navigator.pop(context);
  //         },
  //         color: Theme.of(context).accentColor,
  //         child: Text(
  //           'Save',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //       FlatButton(
  //         onPressed: () async {
  //           final sign = _signAdmin.currentState;
  //           //retrieve image data, do whatever you want with it (send to server, save locally...)
  //           setState(() {
  //             _imgAdmin = ByteData(0);
  //           });
  //           debugPrint("Admin Signature removed ");
  //           sign.clear();
  //         },
  //         color: Theme.of(context).accentColor,
  //         child: Text(
  //           'Clear',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //       FlatButton(
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         color: Theme.of(context).accentColor,
  //         child: Text(
  //           'Cancel',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       )
  //     ],
  //   );
  //   showDialog(context: context, child: adminSignField);
  // }

  // void _clientSignField() {
  //   AlertDialog clientSignField = new AlertDialog(
  //     content: Container(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           AppBar(
  //             leading: Icon(Icons.edit),
  //             elevation: 0,
  //             title: Text('Client Signature'),
  //             backgroundColor: Theme.of(context).accentColor,
  //             centerTitle: false,
  //           ),
  //           Padding(padding: EdgeInsets.only(bottom: 3.0)),
  //           Container(
  //             width: 350,
  //             height: 300.0,
  //             child: Signature(
  //               color: color,
  //               key: _signClient,
  //               onSign: () {
  //                 final sign = _signClient.currentState;
  //                 debugPrint('${sign.points.length} points in the signature');
  //               },
  //               strokeWidth: strokeWidth,
  //             ),
  //             color: Colors.black12,
  //           ),
  //         ],
  //       ),
  //     ),
  //     actions: <Widget>[
  //       FlatButton(
  //         onPressed: () async {
  //           final sign = _signClient.currentState;
  //           //retrieve image data, do whatever you want with it (send to server, save locally...)
  //           final image = await sign.getData();

  //           //convert image into byteData and Base64
  //           // var data = await image.toByteData(
  //           //     format: ui.ImageByteFormat.png);
  //           // final encoded = base64.encode(data.buffer
  //           //     .asUint8List()); //encode into base64

  //           setState(() {
  //             _imgClient = ByteData(1);
  //           });
  //           // debugPrint("onPressed " + encoded);
  //           debugPrint("Client Signature retrieved!");

  //           Navigator.pop(context);
  //         },
  //         color: Theme.of(context).accentColor,
  //         child: Text(
  //           'Save',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //       FlatButton(
  //         onPressed: () async {
  //           final sign = _signClient.currentState;
  //           //retrieve image data, do whatever you want with it (send to server, save locally...)
  //           setState(() {
  //             _imgClient = ByteData(0);
  //           });
  //           debugPrint("Client Signature removed ");
  //           sign.clear();
  //         },
  //         color: Theme.of(context).accentColor,
  //         child: Text(
  //           'Clear',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //       FlatButton(
  //         onPressed: () {
  //           Navigator.pop(context);
  //         },
  //         color: Theme.of(context).accentColor,
  //         child: Text(
  //           'Cancel',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       )
  //     ],
  //   );
  //   showDialog(context: context, child: clientSignField);
  // }

  // _addComponentSheet() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: <Widget>[
  //               Icon(Icons.maximize),
  //               Text(
  //                 'Add Device Component',
  //                 style: TextStyle(fontWeight: FontWeight.bold),
  //               ),
  //               DropdownButton<String>(
  //                 // hint: Text('Choose Component Type!'),
  //                 value: jenisPerangkat,
  //                 onChanged: (String newvalue) {
  //                   setState(() {
  //                     jenisPerangkat = newvalue;
  //                   });
  //                 },
  //                 items: <String>[
  //                   'switch',
  //                   'wireless',
  //                   'kabel',
  //                   'rj45',
  //                   'fiber device',
  //                   ''
  //                 ].map<DropdownMenuItem<String>>((String value) {
  //                   return DropdownMenuItem<String>(
  //                     value: value,
  //                     child: Text(value.toUpperCase()),
  //                   );
  //                 }).toList(),
  //               ),
  //               ListTile(
  //                 leading: Icon(Icons.music_note),
  //                 title: Text('Music'),
  //                 onTap: () {},
  //               ),
  //               ListTile(
  //                 leading: Icon(Icons.music_note),
  //                 title: Text('Music'),
  //                 onTap: () {},
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
