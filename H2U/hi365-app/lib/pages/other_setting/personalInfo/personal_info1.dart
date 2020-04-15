import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/authentication/authentication_bloc.dart';
import 'package:hi365/pages/authentication/authentication_event.dart';
import 'package:hi365/pages/home/home_bloc.dart';

import 'personal_info2.dart';

class PersonalInfo1 extends StatefulWidget {
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<PersonalInfo1> {
  final String title = '為了理解您的活動訊息，\n\n請提供一些資料給我們。';
  final RegExp idRegExp = RegExp(r"^[A-Za-z]{1}[0-9]{9}");
  final TextEditingController _idcController = new TextEditingController();
  Stream currentState;
  Map<String, dynamic> basicInfo = {
    'name': null,
    'govId': null,
    'gender': null
  };

  Stream init() async* {
    yield 0;
    await Future.delayed(Duration(seconds: 1));
    yield 1;
  }

  @override
  void initState() {
    currentState = init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: currentState,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: InkWell(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('登出',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeEvent.init);
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut());
                  },
                ),
                actions: <Widget>[
                  Builder(
                    builder: (ctx) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('下一步',
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                        ),
                        onTap: () {
                          if (basicInfo['name'] == null ||
                              basicInfo['name']?.toString()?.trim() == '') {
                            Scaffold.of(ctx).showSnackBar(SnackBar(
                              content: Text('名字不可為空白。'),
                            ));
                          } else if (basicInfo['name'].toString().length > 32) {
                            Scaffold.of(ctx).showSnackBar(SnackBar(
                              content: Text(
                                  '名字長度過長。(${basicInfo['name'].toString().length}/32)'),
                            ));
                          } else if (_idcController?.value?.text != null &&
                              _idcController?.value?.text?.trim() != '' &&
                              !idRegExp.hasMatch(_idcController.value.text)) {
                            Scaffold.of(ctx).showSnackBar(SnackBar(
                              content: Text('身分證格式錯誤。'),
                            ));
                          } else if (basicInfo['gender'] == null) {
                            Scaffold.of(ctx).showSnackBar(SnackBar(
                              content: Text('請選擇性別。'),
                            ));
                          } else {
                            Navigator.push(
                              ctx,
                              MaterialPageRoute(
                                builder: (ctx) => PersonalInfo2(basicInfo),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: inputAccountInfo(),
              ),
            );
            break;
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
          default:
            return Scaffold(
              body: loadingPage(size),
            );
            break;
        }
      },
    );
  }

  Widget loadingPage(Size size) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Image.asset('assets/setting/img_login_provideinfo@3x.png',
              width: size.width, height: size.height * 0.5),
        ],
      ),
    );
  }

  Widget inputAccountInfo() {
    return InkWell(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  '請輸入您的帳戶資料',
                  style: TextStyle(
                      fontSize: 16, color: Colors.black.withOpacity(0.3)),
                ),
              ),
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
                  color: Theme.of(context).accentColor.withOpacity(0.5),
                ),
                decoration: InputDecoration(
                  hintText: '請輸入',
                  hintStyle: TextStyle(
                      color: Theme.of(context).accentColor.withOpacity(0.5)),
                  labelStyle: TextStyle(
                    color: const Color(0xFF424242),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                onChanged: (v) => basicInfo['name'] = v,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text('身分證字號'),
//                  Text(
//                    ' *',
//                    style: TextStyle(color: Colors.red),
//                  )
                ],
              ),
              TextFormField(
                style: TextStyle(
                  color: Theme.of(context).accentColor.withOpacity(0.5),
                ),
                controller: _idcController
                  ..addListener(() {
                    if (_idcController.value.text.length > 10) {
                      _idcController.value = TextEditingValue(
                        text: basicInfo['govId'],
                      );
                    }
                    basicInfo['govId'] = _idcController.value.text;
                  }),
                decoration: InputDecoration(
                  hintText: '請輸入',
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
                value: basicInfo['gender'],
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 1,
                style: TextStyle(
                    color: Theme.of(context).accentColor.withOpacity(0.5)),
                underline: Container(
                  height: 1,
                  color: Colors.grey,
                ),
                onChanged: (String newValue) {
                  basicInfo['gender'] = newValue;
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
    );
  }
}
