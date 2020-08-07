import 'package:app/description/CCIScoreDescription.dart';
import 'package:app/description/conclusionDescription.dart';
import 'package:app/home/homeBloc.dart';
import 'package:app/home/homeEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../util/appBarFactory.dart';

class CCIScore extends StatefulWidget {
  @override
  CCIScores createState() => CCIScores();
}

class CCIScores extends State<CCIScore> {
  List<Widget> description(Map<String, String> iCD10, int cciScore) {
    List<Widget> toReturn = [];
    toReturn.add(Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        cciScore?.toString() ?? '-',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40,
          //0分:綠色    1~3分: 黃色    4分以上紅色
          color: cciScore == 0
              ? Colors.green
              : cciScore >= 1 && cciScore <= 3 ? Colors.yellow : Colors.red,
        ),
      ),
    ));
    toReturn.add(Text(CCIScoreDescription.title,style: TextStyle(fontSize: 20),));
    toReturn.add(Divider());
    iCD10.forEach((k, v) {
      toReturn.add(Text(
        '${k ?? '-'} : ${v ?? '-'}',
        style: TextStyle(
          fontSize: 20,
          color: Colors.blue,
        ),
      ));
      toReturn.add(Divider());
    });
    toReturn.add(Text(CCIScoreDescription.cciDescription,style: TextStyle(fontSize: 20),));
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    ///build
    return Scaffold(
      appBar: AppBarFactory.custom(
        context: context,
        title: ConclusionDescription.list[0].title,
        leadingImagePath: ConclusionDescription.list[0].imagePath,
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
            children: description(homeBloc.iCD10, homeBloc.cciScore),
          ),
        ),
      ),
    );
  }
}
