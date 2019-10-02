import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jas_survey/flutter_signature_pad.dart';
import 'dart:ui';

class AdminSignField extends StatefulWidget {
  final Function setSign, getSign;
  AdminSignField({@required this.setSign, @required this.getSign});

  @override
  _AdminSignFieldState createState() => _AdminSignFieldState();
}

class _AdminSignFieldState extends State<AdminSignField> {
  // ByteData _imgAdmin = new ByteData(0);
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
    // widget.getSign() == null
    //     ? print("sign Admin was NULL")
    //     : print("sign Admin : " + widget.getSign());
    return Scaffold(
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
                  final sign = _signAdmin.currentState;
                  debugPrint('${sign.points.length} points in the singnature');
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
                    // child: Text("tes"),
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
                      debugPrint("Admin Signature Retrieved!");
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
                    debugPrint("Admin Signature Removed!");
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
