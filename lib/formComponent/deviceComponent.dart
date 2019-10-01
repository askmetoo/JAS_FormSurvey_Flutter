import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jas_survey/listDevicePage/deviceCompListPage.dart';
import 'package:jas_survey/models/deviceComp.dart';

class DeviceComponent extends StatefulWidget {
  @override
  _DeviceComponentState createState() => _DeviceComponentState();
}

class _DeviceComponentState extends State<DeviceComponent> {
  List<DeviceComp> deviceComps = [];
  List<DeviceComp> getDevices() {
    return deviceComps;
  }

  void _removeDeviceDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("Device removed!"),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              )
            ],
          );
        });
  }

  addDevice(DeviceComp newDevice) {
    setState(() {
      deviceComps.add(newDevice);
      Navigator.pop(context);
    });
  }

  removeDevice(index) {
    // print(index);
    setState(() {
      deviceComps.removeAt(index);
    });
    _removeDeviceDialog();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.device_hub),
      title: Text(
        'Device & Component',
        style: TextStyle(fontSize: 17.0, color: Colors.black),
      ),
      trailing: RaisedButton(
        elevation: 0,
        color: Theme.of(context).accentColor,
        child: Text('Add'),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DeviceCompListPage(
                        addDevice: addDevice,
                        setDevice: getDevices,
                        dataDevice: deviceComps,
                        removeDevice: removeDevice,
                      )));
        },
      ),
      enabled: false,
    );
  }
}
