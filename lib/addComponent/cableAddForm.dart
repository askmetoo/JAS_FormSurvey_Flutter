import 'package:flutter/material.dart';
import 'package:jas_survey/models/cable.dart';

class CableAddForm extends StatefulWidget {
  final List<Cable> cables;
  final Function onAddCable;
  CableAddForm({this.cables, this.onAddCable});

  @override
  _CableAddFormState createState() => _CableAddFormState();
}

class _CableAddFormState extends State<CableAddForm> {
  final GlobalKey<FormState> _cableForm = GlobalKey<FormState>();
  Cable dataCable = new Cable();

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
                          value: dataCable.jenisKabel,
                          onChanged: (String newvalue) {
                            setState(() {
                              dataCable.jenisKabel = newvalue;
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
                        onChanged: (String val) {
                          setState(() => dataCable.panjang = val);
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      child: Text('Add Cable'),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        widget.onAddCable(dataCable);
                        _cableForm.currentState.reset();
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
