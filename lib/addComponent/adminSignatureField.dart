import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jas_survey/flutter_signature_pad.dart';
import 'dart:ui';

class AdminSginField extends StatefulWidget {
  @override
  _AdminSginFieldState createState() => _AdminSginFieldState();
}

class _AdminSginFieldState extends State<AdminSginField> {
  ByteData _imgAdmin = new ByteData(0);
  var color = Colors.red;
  var strokeWidth = 5.0;

  final _signAdmin = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
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
            _imgAdmin.buffer.lengthInBytes == 0 ?
            Container()
            :
            Center(
              child: LimitedBox(
                maxHeight: 200.0,
                child: Image.memory(_imgAdmin.buffer.asUint8List()),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MaterialButton(
                  color: Colors.green,
                  child: Text('Save'),
                  onPressed: () async{
                    final sign = _signAdmin.currentState;
                    final image = await sign.getData();
                    var data = await image.toByteData(format: ImageByteFormat.png);
                    final encoded = base64.encode(data.buffer.asUint8List());
                    setState(() {
                      _imgAdmin = data;
                    });
                    debugPrint("Admin Signature Retrieved !");
                  },
                ),
                MaterialButton(
                  color: Colors.green,
                  child: Text('Clear'),
                  onPressed: () async{
                    final sign = _signAdmin.currentState;
                    sign.clear();
                    setState(() {
                      _imgAdmin = ByteData(0);
                    });
                    debugPrint("Admin Signature Removed !");
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
