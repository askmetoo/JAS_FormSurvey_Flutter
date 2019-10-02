import 'package:flutter/material.dart';
import 'package:jas_survey/addComponent/deviceCompAddForm.dart';
import 'package:jas_survey/emptyState.dart';
import 'package:jas_survey/models/deviceComp.dart';

class DeviceCompListPage extends StatefulWidget {
  final Function addDevice;
  final Function setDevice;
  final Function removeDevice;
  final List<DeviceComp> dataDevice;

  DeviceCompListPage(
      {this.addDevice, this.setDevice, this.removeDevice, this.dataDevice});

  @override
  _DeviceCompListPageState createState() => _DeviceCompListPageState();
}

class _DeviceCompListPageState extends State<DeviceCompListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('List of Device and Component'),
        centerTitle: false,
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('SAVE', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //FOR DISPLAY Display List
            Container(
                height: MediaQuery.of(context).size.height * 0.76,
                child: widget.dataDevice.length == 0
                    ? Center(
                        child: EmptyState(
                          title: "Empty..",
                          message: "Belum ada Device / Component yang Diinput",
                        ),
                      )
                    : Container(
                        child: ListView.builder(
                            itemCount: widget.dataDevice.length,
                            itemBuilder: (BuildContext context, int index) =>
                                ListTile(
                                  leading: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: Text(
                                        widget.dataDevice[index].deviceCompType,
                                      )),
                                  title: Text(widget.dataDevice[index].vendor +
                                      " - " +
                                      widget.dataDevice[index].asetNum),
                                  subtitle: Text(
                                      widget.dataDevice[index].jumlah +
                                          " unit"),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      widget.removeDevice(index);
                                    },
                                  ),
                                )),
                      )),
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
                    'Add Device Component',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeviceCompAddForm(
                                deviceComps: widget.dataDevice,
                                onAddDevice: widget.addDevice)));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
