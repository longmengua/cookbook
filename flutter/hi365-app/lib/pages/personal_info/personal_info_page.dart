import 'package:flutter/material.dart';
import 'package:hi365/pages/personal_info/index.dart';
import 'package:hi365/utils/app_configs.dart';

class PersonalInfoPage extends StatelessWidget {
  static const String routeName = "/personalInfo";

  @override
  Widget build(BuildContext context) {
    var _personalInfoBloc = PersonalInfoBloc();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "基本資料",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              '略過',
              style: TextStyle(
                color: AppConfig().primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
      body: PersonalInfoScreen(personalInfoBloc: _personalInfoBloc),
    );
  }
}
