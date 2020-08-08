import 'package:app/description/PersonalHealthRiskAssessmentDescription.dart';
import 'package:app/description/conclusionDescription.dart';
import 'package:app/home/homeBloc.dart';
import 'package:app/home/homeEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../util/appBarFactory.dart';

class PersonalHealthRiskAssessment extends StatefulWidget {
  @override
  PersonalHealthRiskAssessments createState() =>
      PersonalHealthRiskAssessments();
}

class PersonalHealthRiskAssessments
    extends State<PersonalHealthRiskAssessment> {
  HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    num score1 = homeBloc.riskAssessment.aSCVDRisk == null
        ? -1
        : num.tryParse(homeBloc.riskAssessment.aSCVDRisk);
    num score2 = homeBloc.riskAssessment.bRAINRisk == null
        ? -1
        : num.tryParse(homeBloc.riskAssessment.bRAINRisk);
    //0%:綠色    5~20%: 黃色    20%以上紅色
    Color color1 = getColorByScore(score1);
    Color color2 = getColorByScore(score2);

    ///build
    return Scaffold(
      appBar: AppBarFactory.custom(
        context: context,
        title: ConclusionDescription.list[6].title,
        leadingImagePath: ConclusionDescription.list[6].imagePath,
        trailingImagePath: ConclusionDescription.homeIcon,
        trailingImageOnTap: () async {
          homeBloc.add(HomeEvent.conclusion);
        },
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 30, top: 10),
                child: Text(
                  '${homeBloc.riskAssessment.aSCVDRisk ?? "??"}',
                  style: TextStyle(fontSize: 50, color: color1),
                  textAlign: TextAlign.center,
                ),
              ),
              description(
                homeBloc.riskAssessment.aSCVDRisk,
                PersonalHealthRiskAssessmentDescription.m1,
                PersonalHealthRiskAssessmentDescription.m2,
                PersonalHealthRiskAssessmentDescription.m3,
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(bottom: 30, top: 10),
                child: Text(
                  '${homeBloc.riskAssessment.bRAINRisk ?? "??"}',
                  style: TextStyle(fontSize: 50, color: color2),
                  textAlign: TextAlign.center,
                ),
              ),
              description(
                homeBloc.riskAssessment.bRAINRisk,
                PersonalHealthRiskAssessmentDescription.m4,
                PersonalHealthRiskAssessmentDescription.m5,
                PersonalHealthRiskAssessmentDescription.m6,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Color getColorByScore(num score) {
    return score >= 0 && score < 5
        ? Color(0xff11ff11)
        : score >= 5 && score < 21 ? Color(0xffffd47e) : Color(0xffff1111);
  }

  Widget description(String score, String m1, String m2, String m3) {
    if (score == null) return Text(m3, style: TextStyle(fontSize: 20));
    return RichText(
      text: TextSpan(
        text: m1,
        style: TextStyle(color: Color(0xffff2222), fontSize: 20),
        children: [
          TextSpan(
            text: m2,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
