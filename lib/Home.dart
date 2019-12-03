import 'package:flutter/material.dart';
import 'package:jas_survey/homeJAS.dart';
import 'package:jas_survey/scanForm.dart';
import 'package:jas_survey/surveyForm.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeJAS(),
    SurveyForm(),
    ScanForm(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                key: Key('list_survey'),
              ),
              title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.note_add,
                key: Key('add_survey'),
              ),
              title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera_enhance,
                key: Key('scan_survey'),
              ),
              title: Text("")),
        ],
      ),
    );
  }
}