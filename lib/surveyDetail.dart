import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jas_survey/apiService.dart';
import 'package:jas_survey/drawer.dart';
import 'package:jas_survey/emptyState.dart';
import 'package:jas_survey/models/beritaAcara.dart';
import 'package:jas_survey/models/cable.dart';
import 'package:jas_survey/models/deviceComp.dart';

class SurveyDetail extends StatefulWidget {
  BeritaAcara survey;
  SurveyDetail({@required this.survey});
  @override
  _SurveyDetailState createState() => _SurveyDetailState();
}

class _SurveyDetailState extends State<SurveyDetail> {
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Survey Detail'),
          centerTitle: false,
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
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
              Card(
                elevation: 2.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppBar(
                      leading: Icon(Icons.library_books),
                      elevation: 0,
                      title: Text("Survey Info"),
                      backgroundColor: Theme.of(context).accentColor,
                      centerTitle: false,
                    ),
                    Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Text("Location"),
                              title: Text(
                                widget.survey.location,
                                style: Theme.of(context).textTheme.subhead,
                              ),
                              enabled: false,
                            ),
                            ListTile(
                              leading: Text("Date"),
                              title: Text(
                                "   ${widget.survey.date.day}-${widget.survey.date.month}-${widget.survey.date.year}",
                                style: Theme.of(context).textTheme.subhead,
                              ),
                              enabled: false,
                            ),
                            ListTile(
                              leading: Text("Activity"),
                              title: widget.survey.actType != null
                                  ? Text(
                                      "  " + widget.survey.actType,
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                    )
                                  : Text(
                                      "No Activity",
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                    ),
                              enabled: false,
                            ),
                            ListTile(
                              leading: Text("Problem"),
                              title: widget.survey.diagnosis != null
                                  ? Text(
                                      widget.survey.diagnosis,
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                    )
                                  : Text(
                                      " -- ",
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                    ),
                              enabled: false,
                            ),
                            ListTile(
                              leading: Text("Solution"),
                              title: widget.survey.solution != null
                                  ? Text(
                                      widget.survey.diagnosis,
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                    )
                                  : Text(
                                      " -- ",
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                    ),
                              enabled: false,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
              ),

              //Detail components and cables
              Card(
                elevation: 2.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppBar(
                      leading: Icon(Icons.library_books),
                      elevation: 0,
                      title: Text("List of Cables and Components"),
                      backgroundColor: Theme.of(context).accentColor,
                      centerTitle: false,
                    ),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Text("Cables",
                                style: Theme.of(context).textTheme.headline),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                            ),
                            FutureBuilder(
                              future: apiService
                                  .geCablebyIdSurvey(widget.survey.id_survey),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Cable>> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  List<Cable> cables = snapshot.data;
                                  if (cables != null) {
                                    return Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.30,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: cables == null
                                                ? 0
                                                : cables.length,
                                            itemBuilder: (context, index) {
                                              Cable cable = cables[index];
                                              return ListTile(
                                                leading: Text(
                                                    (index + 1).toString()),
                                                title: Text(cable.cable_type +
                                                    " Cable"),
                                                subtitle: Text("Length: " +
                                                    cable.cable_length
                                                        .toString() +
                                                    " M"),
                                              );
                                            },
                                          ),
                                        ));
                                  } else {
                                    return Container(
                                      child: Text(
                                        "No Cable Data",
                                        style:
                                            Theme.of(context).textTheme.title,
                                      ),
                                    );
                                  }
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            Text("Devices / Components",
                                style: Theme.of(context).textTheme.headline),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                            ),
                            FutureBuilder(
                              future: apiService
                                  .geDevicebyIdSurvey(widget.survey.id_survey),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<DeviceComp>> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  List<DeviceComp> devices = snapshot.data;
                                  if (devices != null) {
                                    return Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.30,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: devices == null
                                                ? 0
                                                : devices.length,
                                            itemBuilder: (context, index) {
                                              DeviceComp device =
                                                  devices[index];
                                              return ListTile(
                                                leading: Text(
                                                    (index + 1).toString()),
                                                title:
                                                    Text(device.deviceCompType),
                                                subtitle: Text(device.vendor +
                                                    " -- " +
                                                    device.asetNum +
                                                    " -- " +
                                                    device.jumlah.toString() +
                                                    " unit"),
                                              );
                                            },
                                          ),
                                        ));
                                  } else {
                                    return Container(
                                      child: Text(
                                        "No Device Component Data",
                                        style:
                                            Theme.of(context).textTheme.title,
                                      ),
                                    );
                                  }
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
              ),
              Card(
                elevation: 2.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AppBar(
                      leading: Icon(Icons.library_books),
                      elevation: 0,
                      title: Text("Signed By"),
                      backgroundColor: Theme.of(context).accentColor,
                      centerTitle: false,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("Admin / Tim PSI"),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              LimitedBox(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Image.memory(
                                    base64.decode(widget.survey.adminSign)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              Text(widget.survey.adminName),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("Client"),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              LimitedBox(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Image.memory(
                                    base64.decode(widget.survey.clientSign)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              Text(widget.survey.clientName),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                    )
                  ],
                ),
              ),
              // signature
            ],
          ),
        ));
  }
}
