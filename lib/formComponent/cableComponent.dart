import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jas_survey/listDevicePage/cableListPage.dart';
import 'package:jas_survey/models/cable.dart';

class CableComponent extends StatefulWidget {
  final Function addCable, getCables, removeCable, setCableList;
  final List<Cable> cables;

  CableComponent({this.addCable, this.getCables, this.removeCable, this.cables, this.setCableList});

  @override
  _CableComponentState createState() => _CableComponentState();
}

class _CableComponentState extends State<CableComponent> {
  @override
  Widget build(BuildContext context) {
    
    return ListTile(
      leading: Icon(Icons.device_hub),
      title: Text(
        'Cable',
        style: TextStyle(fontSize: 17.0, color: Colors.black),
      ),
      trailing: RaisedButton(
        key: Key('cableAdd'),
        elevation: 0,
        color: Theme.of(context).accentColor,
        child: Text('Add'),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CableListPage(
                      addCable: widget.addCable,
                      setCable: widget.getCables,
                      dataCable: widget.cables,
                      removeCable: widget.removeCable,
                      setCableList: widget.setCableList)));
        },
      ),
      enabled: false,
    );
  }
}