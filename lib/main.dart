import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'surveyForm.dart';


// import 'flutter_signature_pad.dart';

void main() async {
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Color(0xFF1DCC8C),
        platform: TargetPlatform.iOS
      ),
      // home: MyHomePage(),
      home: SurveyForm(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   DateTime _date = DateTime.now();
//   TimeOfDay _time = TimeOfDay.now();

//   ByteData _imgAdmin = ByteData(0);
//   ByteData _imgClient = ByteData(0);
//   var color = Colors.red;
//   var strokeWidth = 5.0;

//   final _signAdmin = GlobalKey<SignatureState>();
//   final _signClient = GlobalKey<SignatureState>();

//   Future<Null> _selectDate(BuildContext context) async {
//     final DateTime picked = await showDatePicker(
//       context: context,
//       initialDate: _date,
//       firstDate: new DateTime(2016),
//       lastDate: new DateTime(2020),
//     );

//     if (picked != null && picked != _date) {
//       setState(() {
//         _date = picked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget titleSection = Container(
//       padding: const EdgeInsets.only(left: 25, right: 32, top: 32, bottom: 10),
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   padding: const EdgeInsets.only(bottom: 8),
//                   child: Text(
//                     'Tanda Tangan Admin',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );

//     Widget titleClient = Container(
//       padding: const EdgeInsets.only(left: 25, right: 32, top: 32, bottom: 10),
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   padding: const EdgeInsets.only(bottom: 8),
//                   child: Text(
//                     'Tanda Tangan Client',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );

//     Widget signAdmin = Container(
      // padding: EdgeInsets.all(8.0),
      // width: 380.0,
      // height: 250.0,
      // child: Signature(
      //   color: color,
      //   key: _signAdmin,
      //   onSign: () {
      //     final sign = _signAdmin.currentState;
      //     debugPrint('${sign.points.length} points in the signature');
      //   },
      //   strokeWidth: strokeWidth,
      // ),
      // color: Colors.black12,
//     );

//     Widget signClient = Container(
      // padding: EdgeInsets.all(8.0),
      // width: 380.0,
      // height: 250.0,
      // child: Signature(
      //   color: color,
      //   key: _signClient,
      //   onSign: () {
      //     final sign = _signClient.currentState;
      //     debugPrint('${sign.points.length} points in the signature');
      //   },
      //   strokeWidth: strokeWidth,
      // ),
      // color: Colors.black12,
//     );

    // Widget buttonSignAdmin = Container(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: <Widget>[
    //       MaterialButton(
    //         color: Colors.green,
    //         onPressed: () async {
    //           final sign = _signAdmin.currentState;
    //           //retrieve image data, do whatever you want with it (send to server, save locally...)
    //           final image = await sign.getData();
    //           var data = await image.toByteData(format: ui.ImageByteFormat.png);
    //           final encoded =
    //               base64.encode(data.buffer.asUint8List()); //encode into base64
    //           setState(() {
    //             _imgAdmin = data;
    //           });
    //           debugPrint("onPressed " + encoded);
    //           sign.clear();
    //         },
    //         child: Text("Save"),
    //       ),
//           MaterialButton(
//               color: Colors.grey,
//               onPressed: () {
//                 final sign = _signAdmin.currentState;
//                 sign.clear();
//                 setState(() {
//                   _imgAdmin = ByteData(0);
//                 });
//                 debugPrint("cleared");
//               },
//               child: Text("Clear")),
//         ],
//       ),
//     );

//     Widget buttonSignClient = Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           MaterialButton(
//             color: Colors.green,
//             onPressed: () async {
//               final sign = _signClient.currentState;
//               //retrieve image data, do whatever you want with it (send to server, save locally...)
//               final image = await sign.getData();
//               var data = await image.toByteData(format: ui.ImageByteFormat.png);
//               final encoded =
//                   base64.encode(data.buffer.asUint8List()); //encode into base64
//               setState(() {
//                 _imgClient = data;
//               });
//               debugPrint("onPressed " + encoded);
//               sign.clear();
//             },
//             child: Text('Save'),
//           ),
//           MaterialButton(
//               color: Colors.grey,
//               onPressed: () {
//                 final sign = _signClient.currentState;
//                 sign.clear();
//                 setState(() {
//                   _imgClient = ByteData(0);
//                 });
//                 debugPrint("cleared");
//               },
//               child: Text("Clear")),
//         ],
//       ),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Form Berita Acara'),
//         elevation: .0,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF30C1FF),
//               Color(0xFF2AA7DC),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: ListView(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 child: Column(
//                   children: <Widget>[
//                     Text('Rendra'),
//                     Text('Mahardika'),
//                   ],
//                 ),
                
//               ),
//             )
//           ],
//         ),
//       )
//       //  ListView(
//       //   children: <Widget>[
//       //     Container(
//       //       padding: EdgeInsets.all(10.0),
//       //       child: Column(
//       //         children: <Widget>[],
//       //       ),
//       //     ),
//       //     // Padding(
//       //     //   padding: EdgeInsets.all(10),
//       //     //   child: Column(
//       //     //     children: <Widget>[
//       //     //       MaterialButton(
//       //     //         child: Row(
//       //     //           children: <Widget>[
//       //     //             Icon(Icons.date_range),
//       //     //             Padding(padding: EdgeInsets.only(right: 8)),
//       //     //             Text("Select Date", textAlign: TextAlign.left,),
//       //     //             ],
//       //     //         ) ,

//       //     //         onPressed:(){
//       //     //           _selectDate(context);
//       //     //         }
//       //     //       ),
//       //     //       TextField(
//       //     //         decoration: InputDecoration(
//       //     //             border: OutlineInputBorder(), labelText: 'Select Date'),
//       //     //         onTap: () {
//       //     //           _selectDate(context);
//       //     //         },
//       //     //       ),
//       //     // titleSection,
//       //     // signAdmin,
//       //     // buttonSignAdmin,

//       //     // titleClient,
//       //     // signClient,
//       //     // buttonSignClient,

//       //     // //Preview Signature after click save button
//       //     // _imgAdmin.buffer.lengthInBytes == 0
//       //     //     ? Container()
//       //     //     : LimitedBox(
//       //     //         maxHeight: 200.0,
//       //     //         child: Image.memory(_imgAdmin.buffer
//       //     //             .asUint8List())), //to show image after click save button
//       //     // _imgClient.buffer.lengthInBytes == 0
//       //     //     ? Container()
//       //     //     : LimitedBox(
//       //     //         maxHeight: 200.0,
//       //     //         child: Image.memory(_imgClient.buffer
//       //     //             .asUint8List())), //to show image after click save button
//       //   ],
//       // ),
//     );
//   }
// }
