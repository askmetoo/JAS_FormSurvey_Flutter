import 'package:flutter/material.dart';

class Cable {
  String panjang = "";
  String jenisKabel;

  Cable({this.panjang = '', this.jenisKabel});
}

class CableAddForm extends StatefulWidget {
  @override
  _CableAddFormState createState() => _CableAddFormState();
}

class _CableAddFormState extends State<CableAddForm> {
  final GlobalKey<FormState> _cableForm = GlobalKey<FormState>();
  List<Cable> kabels = [];
  Cable dataKabel = new Cable();

  // List<Widget> listCabel() {
  //   List<Widget> result = [];
  //   Widget temp = Text('aa');
  //   result.add(temp);
  //   return result;
  // }

  void addKabel() {
    var cableValid = _cableForm.currentState;
    cableValid.save();
    setState(() {
      var cabel =
          Cable(panjang: dataKabel.panjang, jenisKabel: dataKabel.jenisKabel);
      kabels.add(cabel);
    });

    print(kabels.length);
    kabels.forEach((kabel) {
      print(kabel.panjang);
      print('Cabel added!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Cable Add Form'),
        centerTitle: false,
      ),
      body: ListView(
        
        children: <Widget>[
          Form(
            key: _cableForm,
            child: Container(        
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return DropdownButton<String>(
                          isExpanded: true,
                          hint: Text('Choose Cable Type!'),
                          value: dataKabel.jenisKabel,
                          onChanged: (String newvalue) {
                            setState(() {
                              dataKabel.jenisKabel = newvalue;
                            });
                          },
                          items: <String>[
                            'FO',
                            'UTP',
                            'Listrik',
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
                  ListTile(
                    title: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Cable Length',
                        hintText: 'Type the Length (M)',
                        isDense: true,
                      ),
                      onSaved: (String val) =>
                          setState(() => dataKabel.panjang = val),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      child: Text('Add Cable'),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        addKabel();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
