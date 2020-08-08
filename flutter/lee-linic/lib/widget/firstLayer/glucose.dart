import 'dart:convert';

import 'package:app/description/dashbaordDescription.dart';
import 'package:app/description/glucoseDescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/homeBloc.dart';
import '../../home/homeEvent.dart';
import '../util/appBarFactory.dart';
import '../util/checkBoxBuilder.dart';

class Glucose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    //keys : in order to get radioBox value, instead of passing a controller.
    GlobalKey<RadioBoxBuilders> key = GlobalKey<RadioBoxBuilders>();
    Map data = homeBloc.userJson;
    String systolicBloodPressure = data['systolicBloodPressure'];
    String diastolicBloodPressure = data['diastolicBloodPressure'];
    List isManual = data['isManual']; //1：是，0：否

    ///有無血壓紀錄，則顯示提示視窗。
    if (!homeBloc.hasBloodPressureInfo())
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(GlucoseDescription.snackMsg1),
        )),
      );

    ///build
    return Scaffold(
      appBar: AppBarFactory.custom(
        context: context,
        title: DashBoardDescription.list[3].title,
        leadingImagePath: DashBoardDescription.list[3].imagePath,
        trailingImagePath: DashBoardDescription.homeIcon,
        trailingImageOnTap: () async {
          homeBloc.add(HomeEvent.dashboard);
        },
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                GlucoseDescription.rule1,
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
                  Text(
                    GlucoseDescription.glucoseRecordTitle,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      GlucoseDescription.glucoseRecordContent(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent,
                      ),
                    ),
                  )
                ],
              ),
              FlatButton(
                color: Colors.blueAccent,
                child: Text(
                  GlucoseDescription.previewButton,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),
              Text(
                GlucoseDescription.glucoseMatching,
                style: TextStyle(fontSize: 22),
              ),
              Container(
                height: 100,
                child: Image.asset('assets/images/icon_bp_bs_record_img1.png'),
              ),
              Divider(
                height: 20,
                thickness: 2.0,
              ),
              Text(
                GlucoseDescription.rule2,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Text(
                    GlucoseDescription.systolic,
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: TextField(
                      controller: new TextEditingController(
                          text: systolicBloodPressure),
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        if (num.tryParse(v) is num) systolicBloodPressure = v;
                      },
                    ),
                  ),
                  Text(
                    GlucoseDescription.systolicUnit,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    GlucoseDescription.diastolic,
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: TextField(
                      controller: new TextEditingController(
                          text: diastolicBloodPressure),
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        if (num.tryParse(v) is num) diastolicBloodPressure = v;
                      },
                    ),
                  ),
                  Text(
                    GlucoseDescription.diastolicUnit,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 10),
              FittedBox(
                child: RadioBoxBuilder(
                  groupValue: isManual?.map((v) => v.toString())?.toList(),
                  glucoseRecords: GlucoseDescription.glucoseRecords,
                  glucoseRecordsOptions:
                      GlucoseDescription.glucoseRecordsOptions,
                  key: key,
                ),
              ),
              SizedBox(height: 20),
              FlatButton(
                color: Colors.blueAccent,
                child: Text(
                  GlucoseDescription.button,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  homeBloc.bloodPressureInfo(
                    systolicBloodPressure,
                    diastolicBloodPressure,
                    jsonEncode(key.currentState.groupValue),
                  );
                  FocusScope.of(context).requestFocus(FocusNode());
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(GlucoseDescription.snackMsg),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
