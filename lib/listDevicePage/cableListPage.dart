import 'package:flutter/material.dart';
import 'package:jas_survey/addComponent/cableAddForm.dart';
import 'package:jas_survey/models/cable.dart';
import 'package:jas_survey/emptyState.dart';
import 'package:jas_survey/surveyForm.dart';

class CableListPage extends StatefulWidget {
  final Function addCable;
  final Function setCable;
  final Function removeCable;
  final List<Cable> dataCable;

  CableListPage(
      {this.addCable, this.setCable, this.dataCable, this.removeCable});

  @override
  _CableListPageState createState() => _CableListPageState();
}

class _CableListPageState extends State<CableListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('List of Cables'),
        centerTitle: false,
        actions: <Widget>[
          MaterialButton(
            child: Text(
              "SAVE",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //FOR DISPLAY CABLE LIST
            Container(
              height: MediaQuery.of(context).size.height * 0.76,
              child: widget.dataCable.length == 0
                  ? Center(
                      child: EmptyState(
                        title: "Oops..!!",
                        message: "Belum ada kabel yang diinput",
                      ),
                    )
                  : Container(
                      child: ListView.builder(
                          itemCount: widget.dataCable.length,
                          itemBuilder: (BuildContext context, int index) =>
                              ListTile(
                                leading: Text(
                                  widget.dataCable[index].jenisKabel,
                                ),
                                title: Text("Kabel " +
                                    widget.dataCable[index].jenisKabel),
                                subtitle: Text(
                                    widget.dataCable[index].panjang + " meter"),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    widget.removeCable(index);
                                  },
                                ),
                              )),
                    ),
            ),
            //FOR DISPLAY ADD CABLE BUTTON
            Container(
                height: MediaQuery.of(context).size.height * 0.10,
                padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    bottom: MediaQuery.of(context).size.height * 0.01),
                child: MaterialButton(
                  height: MediaQuery.of(context).size.height * 0.04,
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
                            builder: (context) => CableAddForm(
                                cables: widget.dataCable,
                                onAddCable: widget.addCable)));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
