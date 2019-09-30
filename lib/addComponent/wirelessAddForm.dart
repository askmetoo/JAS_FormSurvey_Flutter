import 'package:flutter/material.dart';
import 'package:jas_survey/models/wireless.dart';

class WirelessAddForm extends StatefulWidget {
  @override
  _WirelessAddFormState createState() => _WirelessAddFormState();
}

class _WirelessAddFormState extends State<WirelessAddForm> {
  final GlobalKey<FormState> _wdForm = GlobalKey<FormState>();

  List<WirelessDevice> wDevices = [];
  WirelessDevice dataWD = new WirelessDevice();

  void addWD() {
    var wdValid = _wdForm.currentState;
    wdValid.save();

    setState(() {
     var wDevice = WirelessDevice(
        vendorWD: dataWD.vendorWD,
        noAsetWD: dataWD.noAsetWD,
        jumlahWD: dataWD.jumlahWD,
      );
      wDevices.add(wDevice);

      print(wDevices.length);
      wDevices.forEach((wDevice) {
        print(wDevice.vendorWD);
        print('Wireless Device added!');
      }); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wireless Device Add Form'),
        centerTitle: false,
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _wdForm,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Vendor / Model',
                        hintText: 'type the vendor',
                        isDense: true,
                      ),
                      onSaved: (String val) =>
                          setState(() => dataWD.vendorWD = val),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'No. Aset / SN',
                        hintText: 'type the Asset Number',
                        isDense: true,
                      ),
                      onSaved: (String val) =>
                          setState(() => dataWD.noAsetWD = val),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: 'type the Amount',
                        isDense: true,
                      ),
                      onSaved: (String val) =>
                          setState(() => dataWD.jumlahWD = val),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      child: Text('Add Wireless Device'),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        addWD();
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
