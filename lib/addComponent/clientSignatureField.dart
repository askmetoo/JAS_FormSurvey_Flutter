import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jas_survey/flutter_signature_pad.dart';
import 'dart:ui';

class ClientSginField extends StatefulWidget {
  final Function setSign, getSign;
  ClientSginField({@required this.setSign, @required this.getSign});
  @override
  _ClientSginFieldState createState() => _ClientSginFieldState();
}

class _ClientSginFieldState extends State<ClientSginField> {
  ByteData _imgClient = new ByteData(0);
  var color = Colors.red;
  var strokeWidth = 5.0;

  final _signClient = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    widget.getSign() == null ?
    print("sign Client was NULL"):
    print("sign Client : " + widget.getSign());
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Signature'),
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
                key: _signClient,
                onSign: () {
                  final sign = _signClient.currentState;
                  debugPrint('${sign.points.length} points in the singnature');
                },
              ),
              color: Colors.black12,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            _imgClient.buffer.lengthInBytes == 0 ?
            Container()
            :
            Center(
              child: LimitedBox(
                maxHeight: 200.0,
                child: Image.memory(base64.decode(widget.getSign())),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MaterialButton(
                  color: Colors.green,
                  child: Text('Save'),
                  onPressed: () async{
                    final sign = _signClient.currentState;
                    final image = await sign.getData();
                    var data = await image.toByteData(format: ImageByteFormat.png);
                    final encoded = base64.encode(data.buffer.asUint8List());
                    widget.setSign(encoded);
                    // setState(() {
                    //   _imgClient = data;
                    // });
                    debugPrint("Client Signature Retrieved !");
                  },
                ),
                 Padding(
                  padding: EdgeInsets.only(left: 8.0),
                ),
                MaterialButton(
                  color: Colors.green,
                  child: Text('Clear'),
                  onPressed: () async{
                    final sign = _signClient.currentState;
                    sign.clear();
                    widget.setSign(null);
                    debugPrint("Client Signature Removed !");
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