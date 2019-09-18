import 'package:flutter/material.dart';
import 'package:jas_survey/addComponent/wirelessAddForm.dart';
import 'package:jas_survey/emptyState.dart';

class WirelessListPage extends StatefulWidget {
  @override
  _WirelessListPageState createState() => _WirelessListPageState();
}

class _WirelessListPageState extends State<WirelessListPage> {
  List<WirelessDevice> wDevices = [];
  WirelessDevice dataWD = new WirelessDevice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Wireless Component'),
        centerTitle: false,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //FOR DISPLAY CABLE LIST
            Container(
                height: MediaQuery.of(context).size.height * 0.80,
                child: wDevices.length == 0
                    ? Center(
                        child: EmptyState(
                          title: "Oops..!!",
                          message: "Belum ada Wireless Component yang diinput",
                        ),
                      )
                    : Container()),
            //FOR DISPLAY ADD CABLE BUTTON
            Container(
                padding: EdgeInsets.only(
                    top: 10.0, left: 15.0, right: 15.0, bottom: 10.0),
                child: MaterialButton(
                  height: 45.0,
                  color: Theme.of(context).accentColor,
                  minWidth: double.infinity,
                  child: Text(
                    'Add Wireless Component',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WirelessAddForm()));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
