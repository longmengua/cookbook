import 'dart:convert';

import 'package:app/description/configDescription.dart';
import 'package:app/description/dashbaordDescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/homeBloc.dart';
import '../../home/homeEvent.dart';
import '../util/appBarFactory.dart';
import '../util/checkBoxBuilder.dart';

// ignore: must_be_immutable
class Config extends StatelessWidget {
  //keys : in order to get radioBox value, instead of passing a callback function.
  final GlobalKey<RadioBoxBuilders> genderKey = GlobalKey<RadioBoxBuilders>();
  final GlobalKey<RadioBoxBuilders> healthKeys = GlobalKey<RadioBoxBuilders>();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    Map data = homeBloc.userJson;
    String age = data['age'];
    String period = data['diabetesDuration'];
    List gender = data['gender'];
    List health = data['health'];

    ///build
    return Scaffold(
      appBar: AppBarFactory.custom(
        context: context,
        title: DashBoardDescription.list[4].title,
        leadingImagePath: DashBoardDescription.list[4].imagePath,
        trailingImagePath: DashBoardDescription.homeIcon,
        trailingImageOnTap: () async {
          homeBloc.add(HomeEvent.dashboard);
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  ConfigDescription.rule1,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 2.0,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text(
                        '${ConfigDescription.ageTitle} : ',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: new TextEditingController(text: age),
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                if (num.tryParse(v) is num) age = v;
                              },
                            ),
                          ),
                          Text(
                            ConfigDescription.ageUnit,
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: RadioBoxBuilder(
                      key: genderKey,
                      groupValue: gender?.map((v) => v.toString())?.toList(),
                      glucoseRecords: ConfigDescription.gender,
                      glucoseRecordsOptions: ConfigDescription.genderOptions,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text(
                        '${ConfigDescription.diabetesPeriod} : ',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller:
                                  new TextEditingController(text: period),
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                if (num.tryParse(v) is num) period = v;
                              },
                            ),
                          ),
                          Text(
                            ConfigDescription.diabetesUnit,
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                FittedBox(
                  child: RadioBoxBuilder(
                    key: healthKeys,
                    groupValue: health?.map((v) => v.toString())?.toList(),
                    glucoseRecords: ConfigDescription.healthRecords,
                    glucoseRecordsOptions:
                        ConfigDescription.healthRecordsOptions,
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 2.0,
                ),
                FlatButton(
                  color: Colors.blueAccent,
                  child: Text(
                    ConfigDescription.confirmButton,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    homeBloc.userInfo(
                      age,
                      period,
                      jsonEncode(genderKey.currentState.groupValue),
                      jsonEncode(healthKeys.currentState.groupValue),
                    );
                    FocusScope.of(context).requestFocus(FocusNode());
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(ConfigDescription.snackMsg),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
