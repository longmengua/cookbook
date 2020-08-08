import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/authentication/authentication_bloc.dart';
import 'package:hi365/pages/authentication/authentication_event.dart';
import 'package:hi365/pages/home/home_bloc.dart';

import 'personal_model.dart';
import 'personal_provider.dart';
import 'widget/dateSelection.dart';
import 'widget/doubleSelection.dart';
import 'widget/error.dart';
import 'widget/loading.dart';
import 'widget/singleSelection.dart';

class PersonalInfo5 extends StatefulWidget {
  final Map<String, dynamic> basicInfo;

  PersonalInfo5(this.basicInfo);

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<PersonalInfo5> {
  final PersonalProvider _personalProvider = PersonalProvider();
  List<PersonalDefine> _personalDefineList = [];
  Bloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _personalDefineList = [];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              child: Align(
                alignment: Alignment.center,
                child: Text('下一步',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Loading()));
                PersonalModel requestBody =
                    PersonalModel.parseMap(widget.basicInfo)
                      ..personalDefineList = _personalDefineList;
                try {
                  await _personalProvider.updatePersonalInfo(requestBody);
                  Navigator.popUntil(context, (router){
                    return true;
//                    return router.settings.isInitialRoute ? true : false;
                  });
                  BlocProvider.of<HomeBloc>(context).add(HomeEvent.dashboard);
                } catch (e) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ErrorPage()));
                  if (Navigator.canPop(context))
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (r) => false);
                }
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: inputAccountInfo(),
      ),
    );
  }

  Widget inputAccountInfo() {
    return Builder(
      builder: (context) => Column(
        children: <Widget>[
          groupTitle('標準值'),
          textField1(context, '舒張壓(低)', 60, 80, 'DiatolicBlood', 'Standard',
              'GE', 'LE'),
          textField1(context, '收縮壓(高)', 90, 120, 'SystolicBlood', 'Standard',
              'GE', 'LE'),
          textField1(
              context, '心率', 60, 100, 'Heartrate', 'Standard', 'GE', 'LE'),
          textField1(context, '血糖', 60, 100, 'BloodThreshold', 'BloodThreshold',
              'LT', 'GT'),
          groupTitle('目標值'),
          textField2(context, '每日步數', 8000, 'Exercise', 'Standard',
              addend: 100),
          textField3(context, '上床時間-起床時間', 22, 0, 8,
              0, 'Sleep', 'SleepTarget', 'GT', 'LE'),
          textField2(context, '目標體重', 50, 'Weight', 'WeightTarget'),
        ],
      ),
    );
  }

  Widget groupTitle(String title) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Color(0xffFAFAF5),
      alignment: Alignment.bottomLeft,
      child: Text(
        title ?? '',
        style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.3)),
      ),
    );
  }

  Widget textField1(BuildContext ctx, String title, num left, num right,
      String group, String type, String num1Type, String num2Type) {
    String _left = left?.toString();
    String _right = right?.toString();

    _personalDefineList.add(PersonalDefine()
      ..creator = widget.basicInfo['name']
      ..creationDateTime =
          DateTime.now().toUtc().toString().replaceAll(' ', 'T')
      ..defGroup = group
      ..type = type
      ..name = title
      ..num1Type = num1Type
      ..num1Value = _left
      ..num2Type = num2Type
      ..num2Value = _right);

    return StatefulBuilder(
      builder: (ctx, state) => InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(title),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text(
                    _left ?? '',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  Text(
                    ' - ',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  Text(
                    _right ?? '',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
        onTap: () async {
          final result = await doubleSelection(context, title, left, right);
          if(result == null)return;
          _left = result['left']?.toString();
          _right = result['right']?.toString();
          _personalDefineList.add(PersonalDefine()
            ..creationDateTime =
                DateTime.now().toUtc().toString().replaceAll(' ', 'T')
            ..num1Value = _left
            ..num2Value = _right);
          state(() {});
        },
      ),
    );
  }

  Widget textField2(
      BuildContext ctx, String title, num value, String group, String type,
      {int addend}) {
    String _value = value?.toString();

    _personalDefineList.add(PersonalDefine()
      ..creator = widget.basicInfo['name']
      ..creationDateTime =
          DateTime.now().toUtc().toString().replaceAll(' ', 'T')
      ..defGroup = group
      ..type = type
      ..name = title
      ..value = _value);

    return StatefulBuilder(
      builder: (ctx, state) => InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(title),
              Text(
                _value ?? '-',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              Divider(),
            ],
          ),
        ),
        onTap: () async {
          final result =
              await singleSelection(context, title, value, addend: addend);
          if(result == null)return;
          _value = result['value']?.toString();
          _personalDefineList.add(PersonalDefine()
            ..creationDateTime =
                DateTime.now().toUtc().toString().replaceAll(' ', 'T')
            ..value = _value);
          state(() {});
        },
      ),
    );
  }

  Widget textField3(
      BuildContext ctx,
      String title,
      num fromHour,
      num fromMinute,
      num toHour,
      num toMinute,
      String group,
      String type,
      String num1Type,
      String num2Type) {
    String _from = '22:00';
    String _to = '08:00';

    _personalDefineList.add(PersonalDefine()
      ..creator = widget.basicInfo['name']
      ..creationDateTime =
          DateTime.now().toUtc().toString().replaceAll(' ', 'T')
      ..defGroup = group
      ..type = type
      ..name = title
      ..num1Type = num1Type
      ..num1Value = _from.replaceAll(':', '')
      ..num2Type = num2Type
      ..num2Value = _to.replaceAll(':', ''));

    return StatefulBuilder(
      builder: (ctx, state) => InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(title),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text(
                    _from ?? '',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  Text(
                    ' - ',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  Text(
                    _to ?? '',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
        onTap: () async {
          final result = await dateSelection(
              context, title, fromHour - 1, fromMinute, toHour - 1, toMinute);
          if(result == null)return;
          if (result['fromHour'] != null && result['fromMinute'] != null) {
            _from =
                '${(result['fromHour'] + 1)?.toString()?.padLeft(2, '0')}:${(result['fromMinute'])?.toString()?.padLeft(2, '0')}';
          }
          if (result['toHour'] != null && result['toMinute'] != null) {
            _to =
                '${(result['toHour'] + 1)?.toString()?.padLeft(2, '0')}:${(result['toMinute'])?.toString()?.padLeft(2, '0')}';
          }
          _personalDefineList.add(PersonalDefine()
            ..creationDateTime =
                DateTime.now().toUtc().toString().replaceAll(' ', 'T')
            ..num1Value = _from.replaceAll(':', '')
            ..num2Value = _to.replaceAll(':', ''));
          state(() {});
        },
      ),
    );
  }
}
