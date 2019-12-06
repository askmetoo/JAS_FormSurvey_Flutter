import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jas_survey/flutter_signature_pad.dart';
import 'dart:ui';

class AdminSignField extends StatefulWidget {
  final Function setSign, getSign;
  AdminSignField({@required this.setSign, @required this.getSign});

  @override
  _AdminSignFieldState createState() => _AdminSignFieldState();
}

class _AdminSignFieldState extends State<AdminSignField> {
  var color = Colors.red;
  var strokeWidth = 5.0;

  final _signAdmin = GlobalKey<SignatureState>();

  void _alertSign(message) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(message),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Admin Signature'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              child: Signature(
                strokeWidth: strokeWidth,
                color: color,
                key: _signAdmin,
                onSign: () {
                  // get sign value
                  // final sign = _signAdmin.currentState;
                },
              ),
              color: Colors.black12,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            widget.getSign() == null
                ? Container()
                : Center(
                    child: LimitedBox(
                    maxHeight: MediaQuery.of(context).size.height * 0.20,
                    child: Image.memory(base64.decode(widget.getSign())),
                  )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MaterialButton(
                  color: Colors.green,
                  child: Text('Save'),
                  onPressed: () async {
                    final sign = _signAdmin.currentState;
                    if (sign.hasPoints == true) {
                      final image = await sign.getData();
                      var data =
                          await image.toByteData(format: ImageByteFormat.png);
                      final encoded = base64.encode(data.buffer.asUint8List());
                      await widget.setSign(encoded);
                      Navigator.pop(context);
                    } else {
                      _alertSign("Admin Signature Cannot be Empty!");
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                ),
                MaterialButton(
                  color: Colors.green,
                  child: Text('Clear'),
                  onPressed: () async {
                    final sign = _signAdmin.currentState;
                    sign.clear();
                    await widget.setSign(null);
                    Navigator.pop(context);
                  },
                ),
                Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
