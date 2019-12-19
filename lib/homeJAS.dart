import 'package:flutter/material.dart';
import 'package:jas_survey/apiService.dart';
import 'package:jas_survey/models/beritaAcara.dart';
import 'package:jas_survey/surveyDetail.dart';
import 'package:jas_survey/surveyForm.dart';
import 'package:jas_survey/emptyState.dart';

class HomeJAS extends StatefulWidget {
  final List<BeritaAcara> surveyList;

  HomeJAS({this.surveyList});
  @override
  _HomeJASState createState() => _HomeJASState();
}

class _HomeJASState extends State<HomeJAS> {
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  detailPage(BeritaAcara data) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SurveyDetail(survey: data)));
  }

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        title: Text('JAS Berita Acara'),
        centerTitle: true,
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
          builder: (BuildContext context,
              AsyncSnapshot<List<BeritaAcara>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: EmptyState(
                  title: "Oops..!!",
                  message:
                      "Something wrong with the server.. :( \n ${snapshot.error.toString()}",
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<BeritaAcara> surveys = snapshot.data;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    BeritaAcara survey = surveys[index];
                    return Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    survey.location,
                                    style: Theme.of(context).textTheme.headline,
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.description,
                                        size: 35.0,
                                      ),
                                      onPressed: () {
                                        var id = survey.idSurvey;
                                        var oneSurvey = surveys
                                            .where((survey) =>
                                                survey.idSurvey == id)
                                            .toList()
                                            .first;
                                        detailPage(oneSurvey);
                                      })
                                ],
                              ),
                              Text(
                                "${survey.date.day}-${survey.date.month}-${survey.date.year}",
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              Text(
                                survey.clientName,
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: surveys == null ? 0 : surveys.length,
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
