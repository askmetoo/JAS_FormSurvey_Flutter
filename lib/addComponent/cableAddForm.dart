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

  String _cableTypeValue;

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
                    key: Key('cableType'),
                    title: FormField<String>(
                      validator: (value){
                        if(dataCable.cableType == null){
                          setState(() {
                           _cableTypeValue = "Please Choose Cable Type!";
                          });
                        }
                      },
                      builder: (FormFieldState<String> state) {
                        return DropdownButton<String>(
                          isExpanded: true,
                          hint: Text('Choose Cable Type!'),
                          value: dataCable.cableType,
                          onChanged: (String newvalue) {
                            setState(() {
                              dataCable.cableType = newvalue;
                              _cableTypeValue = null;
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
                  _cableTypeValue == null
                      ? SizedBox.shrink()
                      : Text(
                          _cableTypeValue ?? "",
                          style: TextStyle(color: Colors.red),
                        ),
                  ListTile(
                    title: TextFormField(
                        key: Key('cableLength'),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Cable Length',
                          hintText: 'Type the Length (M)',
                          isDense: true,
                        ),
                        validator: (value) {
                          if (dataCable.cableLength == null) {
                            return 'Cable length cannot be empty!';
                          }
                        },
                        onChanged: (String val) {
                          setState(() => dataCable.cableLength = int.parse(val));
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: MaterialButton(
                      key: Key('addCableSubmitBtn'),
                      minWidth: double.infinity,
                      child: Text('Add Cable'),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        if(_cableForm.currentState.validate()){
                          if(_cableTypeValue == null){
                            widget.onAddCable(dataCable);
                          }
                        }
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
