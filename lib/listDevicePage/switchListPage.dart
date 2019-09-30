import 'package:flutter/material.dart';
import 'package:jas_survey/addComponent/switchAddForm.dart';
import 'package:jas_survey/emptyState.dart';
import 'package:jas_survey/models/switch.dart';

class SwitchListPage extends StatefulWidget {
  @override
  _SwitchListPageState createState() => _SwitchListPageState();
}

class _SwitchListPageState extends State<SwitchListPage> {
  List<SwitchData> switches = [];
  SwitchData dataSwitch = new SwitchData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('List of Switches Component'),
        centerTitle: false,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //FOR DISPLAY CABLE LIST
            Container(
                height: MediaQuery.of(context).size.height * 0.80,
                child: switches.length == 0
                    ? Center(
                        child: EmptyState(
                          title: "Oops..!!",
                          message: "Belum ada Switch Component yang diinput",
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
                            builder: (context) => SwitchAddForm()));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
