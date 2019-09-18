import 'package:flutter/material.dart';
import 'package:jas_survey/addComponent/cableAddForm.dart';
import 'package:jas_survey/emptyState.dart';

class CableListPage extends StatefulWidget {
  @override
  _CableListPageState createState() => _CableListPageState();
}

class _CableListPageState extends State<CableListPage> {
  List<Cable> kabels = [];
  Cable dataKabel = new Cable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Cables'),
        centerTitle: false,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //FOR DISPLAY CABLE LIST
            Container(
                height: MediaQuery.of(context).size.height * 0.80,
                child: kabels.length == 0
                    ? Center(
                        child: EmptyState(
                          title: "Oops..!!",
                          message: "Belum ada kabel yang diinput",
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
                    'Add Cable',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CableAddForm()));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
