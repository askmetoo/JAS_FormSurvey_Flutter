import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jas_survey/apiService.dart';
import 'package:jas_survey/drawer.dart';
import 'package:jas_survey/models/beritaAcara.dart';
import 'package:jas_survey/models/cable.dart';
import 'package:jas_survey/models/deviceComp.dart';
import 'package:jas_survey/scanForm.dart';
import 'package:jas_survey/surveyForm.dart';
import 'package:http/http.dart' as http;

class HomeJAS extends StatefulWidget {
  final List<BeritaAcara> surveyList;

  HomeJAS({this.surveyList});
  @override
  _HomeJASState createState() => _HomeJASState();
}

class _HomeJASState extends State<HomeJAS> {
  ApiService apiService;

  @override
  void initState(){
    super.initState();
    apiService = ApiService();
  }
  // List surveys = List();

  List<BeritaAcara> listSurvey = [
    // BeritaAcara(
    //   location: "PSI USU",
    //   adminName: "rendra",
    //   clientName: "mahardika",
    //   date:"07-10-2019",
    //   adminSign: "adminSign",
    //   clientSign: "clientSign",
    //   deviceList: [
    //     DeviceComp(
    //       deviceCompType: "Wireless Device",
    //       vendor: "vendor",
    //       asetNum: "1001010",
    //       jumlah: "1"
    //     )
    //   ],
    //   cablesList: [
    //     Cable(jenisKabel: "FO", panjang: "10")
    //   ],
    // ),
    // BeritaAcara(
    //   location: "PSI UNIMED",
    //   adminName: "rendra",
    //   clientName: "mahardika",
    //   date:"08-10-2019",
    //   adminSign: "adminSign",
    //   clientSign: "clientSign",
    //   deviceList: [
    //     DeviceComp(
    //       deviceCompType: "Wireless Device",
    //       vendor: "vendor",
    //       asetNum: "1001010",
    //       jumlah: "1"
    //     )
    //   ],
    //   cablesList: [
    //     Cable(jenisKabel: "FO", panjang: "10")
    //   ],
    // ),
    // BeritaAcara(
    //   location: "FasilkomTI",
    //   adminName: "rendra",
    //   clientName: "mahardika",
    //   date:"010-10-2019",
    //   adminSign: "adminSign",
    //   clientSign: "clientSign",
    //   deviceList: [
    //     DeviceComp(
    //       deviceCompType: "Wireless Device",
    //       vendor: "vendor",
    //       asetNum: "1001010",
    //       jumlah: "1"
    //     )
    //   ],
    //   cablesList: [
    //     Cable(jenisKabel: "FO", panjang: "10")
    //   ],
    // )
  ];

  @override
  Widget build(BuildContext context) {
    // ApiService().getSurvey().then((value)=>print(value));
    // getSurveyData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        key: Key("fabForm"),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SurveyForm()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: Drawer(
        key: Key("drawerBtn"),
        child: DrawerUI(),
      ),
      appBar: AppBar(
        title: Text('JAS Berita Acara'),
        centerTitle: false,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFF90FFC9),
            Color(0xFF80CBc4),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: FutureBuilder(
          future: apiService.getSurvey(),
          builder: (BuildContext context, AsyncSnapshot<List<BeritaAcara>>snapshot){
            if (snapshot.hasError) {
              return Center(
                child:Text("Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if(snapshot.connectionState == ConnectionState.done){
              List<BeritaAcara> surveys = snapshot.data;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListView.builder(
                  itemBuilder: (context, index){
                    BeritaAcara survey = surveys[index];
                    
                  // survey.id_survey is String ? print("yes"):print("no");
                    return Padding(
                      padding: EdgeInsets.only(top:8.0),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                survey.location, 
                                style: Theme.of(context).textTheme.title,
                              ),
                              Text("${survey.date.day}-${survey.date.month}-${survey.date.year}"),
                              Text(survey.clientName)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: surveys.length,
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
