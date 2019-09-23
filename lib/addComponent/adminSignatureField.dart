import 'dart:convert';
import 'dart:typed_data';
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
  ByteData _imgAdmin = new ByteData(0);
  var color = Colors.red;
  var strokeWidth = 5.0;

  final _signAdmin = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    widget.getSign() == null
        ? print("sign Admin was NULL")
        : print("sign Admin : " + widget.getSign());
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
            _imgAdmin.buffer.lengthInBytes == 0
                ? Container()
                : Center(
                    child: LimitedBox(
                    maxHeight: 200.0,
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
                    final image = await sign.getData();
                    var data =
                        await image.toByteData(format: ImageByteFormat.png);
                    final encoded = base64.encode(data.buffer.asUint8List());
                    widget.setSign(encoded);
                    debugPrint("Admin Signature Retrieved !");
                    // Navigator.pop(context, data);
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
                    widget.setSign(null);
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

//Show Signature Result
// Card(
//   elevation: 1.0,
//   child: Column(
//     children: <Widget>[
//       _imgAdmin.buffer.lengthInBytes == 0
//           ? Container()
//           : LimitedBox(
//               maxHeight: 200.0,
//               child: Image.memory(_imgAdmin.buffer
//                   .asUint8List())), //to show image after click save button
//       _imgClient.buffer.lengthInBytes == 0
//           ? Container()
//           : LimitedBox(
//               maxHeight: 200.0,
//               child: Image.memory(_imgClient.buffer
//                   .asUint8List())), //to show image after click save button
//     ],
//   ),
// ),
