import 'package:flutter/material.dart';
import 'package:jas_survey/models/deviceComp.dart';

class DeviceCompAddForm extends StatefulWidget {
  final List<DeviceComp> deviceComps;
  final Function onAddDevice;

  DeviceCompAddForm({this.deviceComps, this.onAddDevice});

  @override
  _DeviceCompAddFormState createState() => _DeviceCompAddFormState();
}

class _DeviceCompAddFormState extends State<DeviceCompAddForm> {
  final GlobalKey<FormState> _deviceCompForm = GlobalKey<FormState>();
  DeviceComp dataDevice = new DeviceComp();

  String _typeValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device & Component Add Form'),
        centerTitle: false,
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _deviceCompForm,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: FormField<String>(
                      validator: (value) {
                        if (dataDevice.deviceCompType == null) {
                          setState(() {
                            _typeValue =
                                "Please Choose Component / Device Type! ";
                          });
                        }
                      },
                      builder: (FormFieldState<String> state) {
                        return DropdownButton<String>(
                          isExpanded: true,
                          hint: Text('Choose Component / Device Type!'),
                          value: dataDevice.deviceCompType,
                          onChanged: (String newvalue) {
                            setState(() {
                              dataDevice.deviceCompType = newvalue;
                              _typeValue = null;
                            });
                          },
                          items: <String>[
                            'Hardware Device',
                            'Switch Component',
                            'Wireless Device Component',
                            'Fiber Devie Component',
                            'RJ-45 Connector'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  _typeValue == null
                      ? SizedBox.shrink()
                      : Text(
                          _typeValue ?? "",
                          style: TextStyle(color: Colors.red),
                        ),
                  ListTile(
                    title: TextFormField(
                      validator: (value) {
                        if (dataDevice.vendor == null) {
                          return 'Vendor cannot be empty!';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Vendor / Model',
                        hintText: 'type the vendor',
                        isDense: true,
                      ),
                      onChanged: (String val) =>
                          setState(() => dataDevice.vendor = val),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      validator: (value) {
                        if (dataDevice.asetNum == null) {
                          return 'Asset Number cannot be empty!';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'No. Aset / SN',
                        hintText: 'type the asset number',
                        isDense: true,
                      ),
                      onChanged: (String val) =>
                          setState(() => dataDevice.asetNum = val),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      validator: (value) {
                        if (dataDevice.vendor == null) {
                          return 'Amount cannot be empty!';
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: 'type the amount',
                        isDense: true,
                      ),
                      onChanged: (String val) =>
                          setState(() => dataDevice.jumlah = val),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      child: Text('Add Device'),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        if (_deviceCompForm.currentState.validate()) {
                          if (_typeValue == null) {
                            widget.onAddDevice(dataDevice);
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
