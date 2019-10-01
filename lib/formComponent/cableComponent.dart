import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jas_survey/listDevicePage/cableListPage.dart';
import 'package:jas_survey/models/cable.dart';

class CableComponent extends StatefulWidget {
  @override
  _CableComponentState createState() => _CableComponentState();
}

class _CableComponentState extends State<CableComponent> {
  List<Cable> cables = [];
  List<Cable> getCables() {
    return cables;
  }

  void _removeCableDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("Cable removed!"),
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

  addCable(Cable newCable) {
    setState(() {
      cables.add(newCable);
      Navigator.pop(context);
    });
  }

  removeCable(index) {
    // print(index);
    setState(() {
      cables.removeAt(index);
    });
    _removeCableDialog();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.device_hub),
      title: Text(
        'Cable',
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
                  builder: (context) => CableListPage(
                      addCable: addCable,
                      setCable: getCables,
                      dataCable: cables,
                      removeCable: removeCable)));
        },
      ),
      enabled: false,
    );
  }
}
