import 'package:flutter/material.dart';

class FiberDevice {
  String vendorFD = "";
  String noAsetFD = "";
  String jumlahFD = "";

  FiberDevice({
    this.vendorFD = '', this.noAsetFD = '', this.jumlahFD = ''
  });
}

class FiberDeviceAddForm extends StatefulWidget {
  @override
  _FiberDeviceAddFormState createState() => _FiberDeviceAddFormState();
}

class _FiberDeviceAddFormState extends State<FiberDeviceAddForm> {
  GlobalKey<FormState> _fdForm = GlobalKey<FormState>();

  List<FiberDevice> fDevices = [];
  FiberDevice dataFD = new FiberDevice();

  void addFD(){
    var fdValid = _fdForm.currentState;
    fdValid.save();
    print('Vendor Fiber Device: ${dataFD.vendorFD}');
    print('No. Aset / SN: ${dataFD.noAsetFD}');
    print('Jumlah: ${dataFD.jumlahFD}');

    setState(() {
     var fDevice = FiberDevice(
       vendorFD: dataFD.vendorFD,
        noAsetFD: dataFD.noAsetFD,
        jumlahFD: dataFD.jumlahFD,
     );
     fDevices.add(fDevice);
     print(fDevices.length);
      fDevices.forEach((fDevice) {
        print(fDevice.vendorFD);
        print('Fiber Device Device added!');
      }); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fiber Device Add Form'),
        centerTitle: false,
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _fdForm,
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
                          setState(() => dataFD.vendorFD = val),
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
                          setState(() => dataFD.noAsetFD = val),
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
                          setState(() => dataFD.jumlahFD = val),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      child: Text('Add Fiber Device'),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        addFD();
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
