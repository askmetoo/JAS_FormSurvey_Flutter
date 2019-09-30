import 'package:flutter/material.dart';
import 'package:jas_survey/models/fiberDevice.dart';
import 'package:jas_survey/addComponent/fiberAddForm.dart';
import 'package:jas_survey/emptyState.dart';

class FiberDeviceListPage extends StatefulWidget {
  @override
  _FiberDeviceListPageState createState() => _FiberDeviceListPageState();
}

class _FiberDeviceListPageState extends State<FiberDeviceListPage> {
  List<FiberDevice> fDevices = [];
  FiberDevice dataFD = new FiberDevice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('List of Fiber Device'),
        centerTitle: false,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //FOR DISPLAY CABLE LIST
            Container(
                height: MediaQuery.of(context).size.height * 0.80,
                child: fDevices.length == 0
                    ? Center(
                        child: EmptyState(
                          title: "Oops..!!",
                          message: "Belum ada Fiber Device yang diinput",
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
                    'Add Switch',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FiberDeviceAddForm()));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
