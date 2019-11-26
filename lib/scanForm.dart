import 'package:flutter/material.dart';

class ScanForm extends StatefulWidget {
  @override
  _ScanFormState createState() => _ScanFormState();
}

class _ScanFormState extends State<ScanForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: Drawer(
        //   child: DrawerUI()
        // ),
        appBar: AppBar(
          title: Text('Scan Survey QR Code'),
          centerTitle: true,
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
