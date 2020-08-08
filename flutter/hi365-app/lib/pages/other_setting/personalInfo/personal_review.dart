import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/authentication/authentication_bloc.dart';
import 'package:hi365/pages/home/home_bloc.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_model.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_provider.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_update.dart';
import 'widget/error.dart';

class PersonalInfoReview extends StatefulWidget {
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<PersonalInfoReview> {
  final RegExp idRegExp = RegExp(r"^[A-Za-z]{1}[0-9]{9}");
  final PersonalProvider _personalProvider = PersonalProvider();
  Map<String, PersonalDefine> _mapping = {};
  PersonalModel _newPersonalModel;
  Future initFuture;

  @override
  void initState() {
    _newPersonalModel = BlocProvider.of<HomeBloc>(context).personalModel;
    _newPersonalModel.personalDefineList.forEach((v) {
      _mapping.putIfAbsent('${v.defGroup}-${v.type}', () => v);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              child: Align(
                alignment: Alignment.center,
                child: Text('編輯',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              onTap: () async {
                try {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => PersonalInfoUpdate()));
                } catch (e) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ErrorPage()));
                  Future.delayed(Duration(seconds: 2)).then((v) {
                    if (Navigator.canPop(context))
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (r) => false);
                  });
                }
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: inputAccountInfo(_newPersonalModel),
      ),
    );
  }

  Widget inputAccountInfo(PersonalModel personalModel) {
    return Builder(
      builder: (context) => Column(
        children: <Widget>[
          groupTitle('個人資料'),
          inputBasicInfo1(personalModel),
          groupTitle('身體量測'),
          inputBasicInfo2(personalModel),
          groupTitle('標準值'),
          textField1(context, '舒張壓(低)', _mapping['DiatolicBlood-Standard'],
              'DiatolicBlood-Standard', 'GE', 'LE'),
          textField1(context, '收縮壓(高)', _mapping['SystolicBlood-Standard'],
              'SystolicBlood-Standard', 'GE', 'LE'),
          textField1(context, '心率', _mapping['Heartrate-Standard'],
              'Heartrate-Standard', 'GE', 'LE'),
          textField1(context, '血糖', _mapping['BloodThreshold-BloodThreshold'],
              'BloodThreshold-BloodThreshold', 'LT', 'GT'),
          groupTitle('目標值'),
          textField4(
              context,
              '每日步數',
              _mapping['Exercise-Standard']?.value == null
                  ? null
                  : _mapping['Exercise-Standard'],
              'Exercise-Standard',
              1000,
              '步',
              addend: 100),
          textField3(context, '上床時間-起床時間', _mapping['Sleep-SleepTarget'],
              'Sleep-SleepTarget', 'GT', 'LE'),
          textField4(
              context,
              '目標體重',
              _mapping['Weight-WeightTarget']?.value == null
                  ? null
                  : _mapping['Weight-WeightTarget'],
              'Weight-WeightTarget',
              50,
              '公斤'),
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

  Widget textField1(
      BuildContext ctx,
      String title,
      PersonalDefine personalDefine,
      String fieldName,
      String num1type,
      String num2type) {
    personalDefine = personalDefine ??
        PersonalDefine.isNull(fieldName,
            num1type: num1type, num2type: num2type, name: title);
    String _left = num.tryParse(personalDefine?.num1Value).toInt().toString();
    String _right = num.tryParse(personalDefine?.num2Value).toInt().toString();
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
                    style: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                  ),
                  Text(
                    ' - ',
                    style: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                  ),
                  Text(
                    _right ?? '',
                    style: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField2(BuildContext ctx, String title, num value, String fieldName,
      String unit) {
    String _value = value.toString();
    return StatefulBuilder(
      builder: (ctx, state) => InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(title),
              Text(
                '${_value ?? '-'} $unit',
                style: TextStyle(
                    color: Theme.of(context).accentColor.withOpacity(0.5)),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField4(
      BuildContext ctx,
      String title,
      PersonalDefine personalDefine,
      String fieldName,
      num cardinalNumber,
      String unit,
      {num addend}) {
    personalDefine = personalDefine ?? PersonalDefine.isNull(fieldName);
    personalDefine.name = title;
    String _value = personalDefine?.value;
    return StatefulBuilder(
      builder: (ctx, state) => InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(title),
              Text(
                '${_value ?? '-'} $unit',
                style: TextStyle(
                    color: Theme.of(context).accentColor.withOpacity(0.5)),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField3(
      BuildContext ctx,
      String title,
      PersonalDefine personalDefine,
      String fieldName,
      String num1type,
      String num2type) {
    personalDefine = personalDefine ??
        PersonalDefine.isNull(fieldName,
            num1type: num1type, num2type: num2type, name: title);
    num fromHour;
    num fromMinute;
    num toHour;
    num toMinute;
    if (personalDefine?.num1Value != null) {
      fromHour = num.tryParse(personalDefine.num1Value.substring(0, 2)).toInt();
      fromMinute =
          num.tryParse(personalDefine.num1Value.substring(2, 4)).toInt();
    }
    if (personalDefine?.num2Value != null) {
      toHour = num.tryParse(personalDefine.num2Value.substring(0, 2)).toInt();
      toMinute = num.tryParse(personalDefine.num2Value.substring(2, 4)).toInt();
    }
    String _from =
        '${(fromHour)?.toString()?.padLeft(2, '0') ?? ''}:${(fromMinute)?.toString()?.padLeft(2, '0') ?? ''}';
    String _to =
        '${(toHour)?.toString()?.padLeft(2, '0') ?? ''}:${(toMinute)?.toString()?.padLeft(2, '0') ?? ''}';

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
                    style: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                  ),
                  Text(
                    ' - ',
                    style: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                  ),
                  Text(
                    _to ?? '',
                    style: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputBasicInfo1(PersonalModel personalModel) {
    bool isLegal = personalModel?.govId != null &&
        personalModel?.govId?.length == 10 &&
        idRegExp.hasMatch(personalModel?.govId);
    String account = BlocProvider.of<AuthenticationBloc>(context)
                    ?.user
                    ?.email !=
                null &&
            BlocProvider.of<AuthenticationBloc>(context).user.email.trim() != ''
        ? BlocProvider.of<AuthenticationBloc>(context)?.user?.email
        : BlocProvider.of<AuthenticationBloc>(context)?.user?.phoneNumber !=
                    null &&
                BlocProvider.of<AuthenticationBloc>(context)
                        .user
                        .phoneNumber
                        .trim() !=
                    ''
            ? BlocProvider.of<AuthenticationBloc>(context)?.user?.phoneNumber
            : '-';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('帳號'),
          Text(account,
              style: TextStyle(
                  color: Theme.of(context).accentColor.withOpacity(0.5))),
          SizedBox(
            height: 10,
          ),
          Text('姓名'),
          Text(personalModel?.name ?? '-',
              style: TextStyle(
                  color: Theme.of(context).accentColor.withOpacity(0.5))),
          SizedBox(
            height: 10,
          ),
          Text('生日'),
          Text(personalModel?.birthday ?? '-',
              style: TextStyle(
                  color: Theme.of(context).accentColor.withOpacity(0.5))),
          SizedBox(
            height: 10,
          ),
          Text('身分證字號'),
          Text(
              isLegal
                  ? personalModel.govId
                      .replaceRange(0, personalModel.govId.length - 4, '******')
                  : '-',
              style: TextStyle(
                  color: Theme.of(context).accentColor.withOpacity(0.5))),
          SizedBox(
            height: 10,
          ),
          Text('性別'),
          Text(personalModel?.gender?.toLowerCase() == 'm' ? '男生' : '女生' ?? '-',
              style: TextStyle(
                  color: Theme.of(context).accentColor.withOpacity(0.5))),
        ],
      ),
    );
  }

  Widget inputBasicInfo2(PersonalModel personalModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('身高'),
          Text(personalModel?.height ?? '-',
              style: TextStyle(
                  color: Theme.of(context).accentColor.withOpacity(0.5))),
          SizedBox(
            height: 10,
          ),
          Text('體重'),
          Text(personalModel?.weight ?? '-',
              style: TextStyle(
                  color: Theme.of(context).accentColor.withOpacity(0.5))),
        ],
      ),
    );
  }
}
