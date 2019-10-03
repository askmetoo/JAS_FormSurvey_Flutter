import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jas_survey/listDevicePage/deviceCompListPage.dart';
import 'package:jas_survey/models/deviceComp.dart';

class DeviceComponent extends StatefulWidget {
  final Function addDevice, getDevices, removeDevice, setDeviceList;
  final List<DeviceComp> deviceComps;

  DeviceComponent(
      {this.addDevice, this.getDevices, this.removeDevice, this.setDeviceList, this.deviceComps});
  @override
  _DeviceComponentState createState() => _DeviceComponentState();
}

class _DeviceComponentState extends State<DeviceComponent> {
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
                        addDevice: widget.addDevice,
                        setDevice: widget.getDevices,
                        dataDevice: widget.deviceComps,
                        removeDevice: widget.removeDevice,
                        setDeviceList: widget.setDeviceList,
                      )));
        },
      ),
      enabled: false,
    );
  }
}
