import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hi365/pages/checkup/checkup_model.dart';
import 'package:hi365/pages/checkup/checkup_repository.dart';
import 'package:hi365/pages/medical_examination/directory/report_directory.dart';

class ExamReportDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  _BodyState createState() {
    return _BodyState();
  }
}

class _BodyState extends State {
  final CheckupRepository _checkupRepository = CheckupRepository();
  final msg01 = '所有健檢項目皆已完成';
  List fakeDate;
  Future future;
  String selected;

  void state() {
    setState(() {});
  }

  @override
  void initState() {
    future = _checkupRepository.fetchInsitutions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        Widget widget;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            widget = Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.done:
            List<String> list = [];
            if (snapshot.data is List<CheckupInstitution>) {
              list = (snapshot.data as List<CheckupInstitution>)
                  .map((v) => v.name)
                  .toList();
            }
            widget = body(size, list);
            break;
        }
        return widget;
      },
    );
  }

  Widget body(Size size, List<String> data) =>
      SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Spacer(),
                DropdownButton(
                    value: selected,
                    hint: Text('請選擇機構.'),
                    items: data
                        .map((v) =>
                        DropdownMenuItem(
                          value: v,
                          child: Text(v.toString()),
                        ))
                        .toList(),
                    onChanged: (value) {
                      selected = value;
                      setState(() {});
                    }),
                Spacer(),
              ],),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: OutlineButton(child: Text('select'), onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ExamReportDirectory(),
                    ),
                  );
                },),
              ),
            ],
          ),
        ),
      );
}
