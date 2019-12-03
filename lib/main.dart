import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:jas_survey/Home.dart';
import 'package:jas_survey/homeJAS.dart';
import 'package:jas_survey/imagePicker.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JAS APP',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Color(0xFF1DCC8C),
        platform: TargetPlatform.iOS
      ),
      // home: ImagePicker(),
      home: Home(),
      // home: HomeJAS(),
      // home: SurveyForm(),
    );
  }
}