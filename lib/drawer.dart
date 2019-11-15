import 'package:flutter/material.dart';
import 'package:jas_survey/homeJAS.dart';
import 'package:jas_survey/scanForm.dart';
import 'package:jas_survey/surveyForm.dart';

class DrawerUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
          ),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  "JAS - PSI USU",
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              ListTile(
                key: Key("homeMenu"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeJAS()));
                },
                title: Row(
                  children: <Widget>[
                    Icon(Icons.list),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                    ),
                    Text("Survey List")
                  ],
                ),
              ),
              ListTile(
                key: Key("addFormMenu"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SurveyForm()));
                },
                title: Row(
                  children: <Widget>[
                    Icon(Icons.note_add),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                    ),
                    Text("New Survey")
                  ],
                ),
              ),
              ListTile(
                key: Key('scanForm'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScanForm()));
                  print("Scan Form");
                },
                title: Row(
                  children: <Widget>[
                    Icon(Icons.camera_alt),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                    ),
                    Text("Scan Form")
                  ],
                ),
              )
            ],
          ),
        );
  }
}