import 'package:flutter/material.dart';
import 'package:jas_survey/homeJAS.dart';
import 'package:jas_survey/surveyForm.dart';
import 'package:barcode_scan/barcode_scan.dart';

class ScanForm extends StatefulWidget {
  @override
  _ScanFormState createState() => _ScanFormState();
}

class _ScanFormState extends State<ScanForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Container(
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeJAS()));
                    print("Survey List Menu");
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SurveyForm()));
                    print("New Survey");
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
          ),
        ),
        appBar: AppBar(
          title: Text('Scan Survey QR Code'),
          centerTitle: false,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                      top: 10.0, right: 3.0, left: 3.0, bottom: 10.0),
                  child: Column(
                    children: <Widget>[
                      MaterialButton(
                        height: 50.0,
                        color: Colors.teal,
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.camera_alt, color: Colors.white,),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Scan Barcode Form", style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 30.0),
                      MaterialButton(
                        
                        height: 50.0,
                        color: Colors.teal,
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Submit", style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
