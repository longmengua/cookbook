import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/authentication/authentication_bloc.dart';
import 'contact_us_model.dart';
import 'contact_us_provider.dart';
import 'history.dart';

class ContactUs extends StatefulWidget {
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<ContactUs> {
  final ContactUsProvider _contactUsProvider = ContactUsProvider();
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _map = {
    '10': '健康檢查',
    '20': '健康活動',
    '30': '諮詢服務',
    '99': '其他'
  };
  RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp phoneRegExp = RegExp(r"^[0-9.]");
  ContactUsModel _contactUsModel = ContactUsModel();
  bool _showMsg = false;
  bool _blockButton = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '聯絡我們',
          style: TextStyle(fontSize: 17),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20, top: 0),
            child: InkWell(
              child: Image.asset(
                'assets/reachUs/ic_nv_download_orange@2x.png',
                height: 22,
                width: 22,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => History(_map),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('問題類型'),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  DropdownButton<String>(
                    hint: Text('請選擇'),
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: _showMsg ? Colors.red : Colors.grey,
                    ),
                    value: _contactUsModel.questionType,
                    items: _map.keys.map((k) {
                      return DropdownMenuItem(
                        value: k,
                        child: Text(_map[k]),
                      );
                    }).toList(),
                    onChanged: (String key) {
                      _contactUsModel.questionType = key;
                      setState(() {});
                    },
                  ),
                  Opacity(
                    opacity: _showMsg ? 1 : 0,
                    child: Text(
                      '問題類型不得為空。',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text('聯絡E-mail'),
//                    Text(
//                      '*',
//                      style: TextStyle(color: Colors.red),
//                    )
                    ],
                  ),
                  TextFormField(
                    initialValue: BlocProvider.of<AuthenticationBloc>(context)
                            ?.user
                            ?.email ??
                        '',
                    decoration: InputDecoration(
                      hintText: '請輸入',
                      labelStyle: TextStyle(
                        color: const Color(0xFF424242),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value.isNotEmpty && !emailRegExp.hasMatch(value))
                        return 'E-mail不符合格式。';
                      _contactUsModel.contactEmail = value;
                      return null;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Text('聯絡電話'),
//                    Text(
//                      '*',
//                      style: TextStyle(color: Colors.red),
//                    )
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '請輸入',
                      labelStyle: TextStyle(
                        color: const Color(0xFF424242),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value.isNotEmpty && !phoneRegExp.hasMatch(value))
                        return '聯絡電話不符合格式。';
                      _contactUsModel.contactPhone = value;
                      return null;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Text('提問內容'),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  TextFormField(
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText: '請輸入',
                      labelStyle: TextStyle(
                        color: const Color(0xFF424242),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.trimLeft().length == 0) {
                        return '內容不得為空。';
                      } else if (value.length > 500) {
                        return '字數不得超過500。(${value.length}/500}';
                      }
                      _contactUsModel.question = value.trim();
                      return null;
                    },
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      _showMsg =
                          _contactUsModel.questionType == null ? true : false;
                      if (!_showMsg &&
                          _formKey.currentState.validate() && !_blockButton) {
                        _blockButton = true;

                        ///The format of Utc is incomplete in dart, it lacking 'T'.
                        try {
                          _contactUsModel.questionTime = DateTime.now()
                              .toUtc()
                              .toString()
                              .replaceAll(' ', 'T');
                          Scaffold.of(context)
                            ..showSnackBar(SnackBar(
                              content: Text('資料傳送中...'),
                            ));
                          await _contactUsProvider
                              .saveContactUsInfo(_contactUsModel)
                              .timeout(Duration(seconds: 10), onTimeout: () {
                            _blockButton = false;
                            return;
                          });
                          Scaffold.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                              content: Text('已完成。'),
                            ));
                          _blockButton = false;
                          Navigator.of(context).pop();
                        } catch (e) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('發生不可預期的錯誤。'),
                          ));
                          _blockButton = false;
                        }
                      }
                    },
                    child: Container(
                      width: size.width * 0.9,
                      height: 44.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius:
                              BorderRadius.all(Radius.circular(22.0))),
                      child: Text(
                        '送出',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
