import 'package:flutter/material.dart';

class SwitchData {
  String vendorSwitch = "";
  String noAsetSwitch = "";
  String jumlahSwitch = "";

  SwitchData(
      {this.vendorSwitch = '', this.noAsetSwitch = '', this.jumlahSwitch = ''});
}

class SwitchAddForm extends StatefulWidget {
  @override
  _SwitchAddFormState createState() => _SwitchAddFormState();
}

class _SwitchAddFormState extends State<SwitchAddForm> {
  final GlobalKey<FormState> _switchForm = GlobalKey<FormState>();

  List<SwitchData> switches = [];
  SwitchData dataSwitch = new SwitchData();

  void addSwitch() {
    var switchValid = _switchForm.currentState;
    switchValid.save();
    
    setState(() {
      var switche = SwitchData(
        vendorSwitch: dataSwitch.vendorSwitch,
        noAsetSwitch: dataSwitch.noAsetSwitch,
        jumlahSwitch: dataSwitch.jumlahSwitch,
      );
      switches.add(switche);

      print(switches.length);
      switches.forEach((switche) {
        print(switche.vendorSwitch);
        print('Switch added!');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Switch Add Form'),
        centerTitle: false,
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _switchForm,
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
                          setState(() => dataSwitch.vendorSwitch = val),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'No. Aset / SN',
                        hintText: 'type the asset number',
                        isDense: true,
                      ),
                      onSaved: (String val) =>
                          setState(() => dataSwitch.noAsetSwitch = val),
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: 'type the amount',
                        isDense: true,
                      ),
                      onSaved: (String val) =>
                          setState(() => dataSwitch.jumlahSwitch = val),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      child: Text('Add Switch'),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        addSwitch();
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
