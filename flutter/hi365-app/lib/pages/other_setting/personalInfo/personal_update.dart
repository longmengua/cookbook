import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/home/home_bloc.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_model.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_provider.dart';
import 'package:hi365/pages/other_setting/personalInfo/widget/loading.dart';

import 'widget/dateSelection.dart';
import 'widget/doubleSelection.dart';
import 'widget/error.dart';
import 'widget/singleSelection.dart';

class PersonalInfoUpdate extends StatefulWidget {
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<PersonalInfoUpdate> {
  final PersonalProvider _personalProvider = PersonalProvider();
  final RegExp idRegExp = RegExp(r"^[A-Za-z]{1}[0-9]{9}");
  final RegExp birthdayRegExp =
      RegExp(r"([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))");
  final TextEditingController _idcController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _birthController = new TextEditingController();
  Map<String, PersonalDefine> _mapping = {};
  PersonalModel _newPersonalModel = new PersonalModel();
  Future initFuture;
  bool isReadOnly = false;

  @override
  void initState() {
    _newPersonalModel.gender =
        BlocProvider.of<HomeBloc>(context).personalModel.gender;
    _newPersonalModel.birthday =
        BlocProvider.of<HomeBloc>(context).personalModel.birthday;
    _newPersonalModel.height =
        BlocProvider.of<HomeBloc>(context).personalModel.height;
    _newPersonalModel.weight =
        BlocProvider.of<HomeBloc>(context).personalModel.weight;
    _newPersonalModel.name =
        BlocProvider.of<HomeBloc>(context).personalModel.name;
    _newPersonalModel.govId =
        BlocProvider.of<HomeBloc>(context).personalModel.govId;
    _newPersonalModel.personalDefineList =
        BlocProvider.of<HomeBloc>(context).personalModel.personalDefineList;
    _newPersonalModel.personalDefineList.forEach((v) {
      _mapping.putIfAbsent('${v.defGroup}-${v.type}', () => v);
    });
    isReadOnly = !(_newPersonalModel.govId == null ||
        _newPersonalModel.govId.trim().length == 0);
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
                child: Text('更新個人資料',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              onTap: () async {
                try {
                  if (!validation(_newPersonalModel)) return;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Loading()));
                  _newPersonalModel.personalDefineList =
                      _mapping.values.toList();
                  bool isSuccessful = await _personalProvider
                      .updatePersonalInfo(_newPersonalModel);
                  if (isSuccessful)
                    BlocProvider.of<HomeBloc>(context).personalModel =
                        _newPersonalModel;
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
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
          inputBasicInfo(personalModel),
          groupTitle('身體量測'),
          textField2(
              context,
              '身高',
              personalModel.height == null
                  ? 170
                  : num.tryParse(personalModel.height)?.toInt(),
              'height',
              '公分'),
          textField2(
              context,
              '體重',
              personalModel.weight == null
                  ? 60
                  : num.tryParse(personalModel.weight)?.toInt(),
              'weight',
              '公斤'),
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
        onTap: () async {
          final result = await doubleSelection(
              context,
              title,
              personalDefine?.num1Value == null
                  ? 50
                  : num.tryParse(personalDefine?.num1Value).toInt(),
              personalDefine?.num2Value == null
                  ? 50
                  : num.tryParse(personalDefine?.num2Value).toInt());
          if (result == null) return;
          _left = result['left']?.toString();
          _right = result['right']?.toString();
          personalDefine?.num1Value = _left;
          personalDefine?.num2Value = _right;
          personalDefine?.creator = _newPersonalModel?.name;
          personalDefine?.creationDateTime =
              DateTime.now().toUtc().toString().replaceAll(' ', 'T');
          _mapping[fieldName] = personalDefine;
          state(() {});
        },
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
        onTap: () async {
          FocusScope.of(context).unfocus();
          final result =
              await singleSelection(context, title, num.tryParse(_value));
          if (result == null) return;
          _value = result['value']?.toString();
          if (fieldName == 'height') _newPersonalModel.height = _value;
          if (fieldName == 'weight') _newPersonalModel.weight = _value;
          state(() {});
        },
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
        onTap: () async {
          FocusScope.of(context).unfocus();
          final result = await singleSelection(context, title,
              _value == null ? cardinalNumber : num.tryParse(_value),
              addend: addend);
          if (result == null) return;
          _value = result['value']?.toString();
          personalDefine?.value = _value;
          personalDefine?.creator = _newPersonalModel?.name;
          personalDefine?.creationDateTime =
              DateTime.now().toUtc().toString().replaceAll(' ', 'T');
          _mapping[fieldName] = personalDefine;
          state(() {});
        },
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
                    '${(fromHour)?.toString()?.padLeft(2, '0') ?? ''}:${(fromMinute)?.toString()?.padLeft(2, '0') ?? ''}',
                    style: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                  ),
                  Text(
                    ' - ',
                    style: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                  ),
                  Text(
                    '${(toHour)?.toString()?.padLeft(2, '0') ?? ''}:${(toMinute)?.toString()?.padLeft(2, '0') ?? ''}',
                    style: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
        onTap: () async {
          final result = await dateSelection(
              context,
              title,
              fromHour == null ? 12 : fromHour - 1,
              fromMinute ?? 0,
              toHour == null ? 12 : toHour - 1,
              toMinute ?? 0);

          if (result == null) return;

          fromHour = result['fromHour'] + 1;
          fromMinute = result['fromMinute'];
          toHour = result['toHour'] + 1;
          toMinute = result['toMinute'];

          personalDefine?.num1Value =
              '${(result['fromHour'] + 1)?.toString()?.padLeft(2, '0')}${(result['fromMinute'])?.toString()?.padLeft(2, '0')}';
          personalDefine?.num2Value =
              '${(result['toHour'] + 1)?.toString()?.padLeft(2, '0')}${(result['toMinute'])?.toString()?.padLeft(2, '0')}';
          personalDefine?.creator = _newPersonalModel?.name;
          personalDefine?.creationDateTime =
              DateTime.now().toUtc().toString().replaceAll(' ', 'T');
          _mapping[fieldName] = personalDefine;
          state(() {});
        },
      ),
    );
  }

  Widget inputBasicInfo(PersonalModel personalModel) {
    if (!isReadOnly) {
      _idcController.addListener(() {
        if (_idcController.value.text.length > 10) {
          _idcController.value = TextEditingValue(
            text: _idcController.value.text
                .substring(0, _idcController.value.text.length - 1),
          );
        }
        personalModel?.govId = _idcController.value.text;
      });
    } else {
      if (personalModel.govId.length < 5) throw Exception('身分證長度不正確，請確認資料庫資料。');
      _idcController
        ..value = TextEditingValue(
            text: personalModel.govId
                .replaceRange(0, personalModel.govId.length - 4, '******'));
    }
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('姓名'),
                    Text(
                      ' *',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                TextFormField(
                  style: TextStyle(
                      color: Theme.of(context).accentColor.withOpacity(0.5)),
                  controller: _nameController
                    ..value = TextEditingValue(text: personalModel.name),
                  decoration: InputDecoration(
                    hintText: '請輸入姓名',
                    hintStyle: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                    labelStyle: TextStyle(
                      color: const Color(0xFF424242),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  onChanged: (v) {
                    if (v.isEmpty || v.trim() == '') {
                      _nameController..value = TextEditingValue(text: '');
                      personalModel.name = '';
                      return;
                    }
                    personalModel.name = v.trim();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text('生日'),
                    Text(
                      ' *',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                TextFormField(
                  style: TextStyle(
                      color: Theme.of(context).accentColor.withOpacity(0.5)),
                  controller: _birthController
                    ..value =
                        TextEditingValue(text: personalModel?.birthday ?? ''),
                  decoration: InputDecoration(
                    hintText: '請輸入生日',
                    hintStyle: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                    labelStyle: TextStyle(
                      color: const Color(0xFF424242),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  onChanged: (v) {
                    if (v.length > 10) {
                      _birthController
                        ..value = TextEditingValue(
                            text: personalModel?.birthday ?? '');
                      return;
                    }
                    personalModel.birthday = v;
                  },
                ),
                Text(
                  '(生日格式 => 1990-01-01。)',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text('身分證字號'),
                    Text(
                      ' *',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                TextFormField(
                  style: TextStyle(
                      color: Theme.of(context).accentColor.withOpacity(0.5)),
                  readOnly: isReadOnly,
                  controller: _idcController,
                  decoration: InputDecoration(
                    hintText: '-',
                    hintStyle: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                    labelStyle: TextStyle(
                      color: const Color(0xFF424242),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '(身分證字號輸入後將無法再修改，若需修改請洽管理人員。)',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text('性別'),
                    Text(
                      ' *',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                DropdownButton<String>(
                  hint: Text(
                    '請輸入',
                    style: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.5),
                        fontSize: 16),
                  ),
                  isExpanded: true,
                  value: personalModel.gender,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 1,
                  style: TextStyle(
                      color: Theme.of(context).accentColor.withOpacity(0.5)),
                  underline: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  onChanged: (String v) {
                    personalModel.gender = v;
                    setState(() {});
                  },
                  items: {'M': '男生', 'F': '女生'}
                      .map((k, v) => MapEntry(
                          k,
                          DropdownMenuItem(
                            value: k,
                            child: Text(v),
                          )))
                      .values
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validation(PersonalModel newPersonalModel) {
    bool toReturn = true;
    List<String> errorMsg = [];
    if (newPersonalModel?.name == null || newPersonalModel?.name?.trim() == '') {
      errorMsg.add('姓名不可空白。\n');
    } else if (newPersonalModel?.name != null &&
        newPersonalModel.name.length > 32) {
      errorMsg.add('姓名長度過長。(/32)\n');
    } else if (!birthdayRegExp.hasMatch(newPersonalModel.birthday)) {
      errorMsg.add('生日不符合格式!\n');

      ///DateTime.parse(), cannot parse special character.
    } else if (!(DateTime.parse(newPersonalModel.birthday).month ==
        num.tryParse(newPersonalModel.birthday?.substring(5, 7)))) {
      errorMsg.add('生日日期超出該月份!\n');
    } else if (newPersonalModel.govId != null &&
        !idRegExp.hasMatch(newPersonalModel.govId)) {
      if (newPersonalModel.govId?.length == 0) {
        newPersonalModel.govId = null;
      } else {
        errorMsg.add('身分證不符合格式!\n');
      }
    }
    if (errorMsg.length > 0) {
      toReturn = false;
      _showDialog(errorMsg);
    }
    return toReturn;
  }

  Future _showDialog(
    List<String> content,
  ) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            "錯誤訊息",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: Column(
                  children: content.map((value) {
                    return Text(
                      value ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, color: Colors.red),
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black.withOpacity(0.3)),
                          right:
                              BorderSide(color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                      child: GestureDetector(
                        child: new Text(
                          "確認",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff396C9B)),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
