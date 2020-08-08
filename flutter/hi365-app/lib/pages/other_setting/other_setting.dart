import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/authentication/authentication_bloc.dart';
import 'package:hi365/pages/authentication/authentication_event.dart';
import 'package:hi365/pages/forgot_password/forgot_password_email_page.dart';
import 'package:hi365/pages/home/home_bloc.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_review.dart';

import 'contact_us/contact_us.dart';
import 'personalInfo/personal_update.dart';
import 'version/version.dart';

class OtherSetting extends StatefulWidget {
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<OtherSetting> {
  Bloc _bloc;
  List<_Directory> _list;

  @override
  void initState() {
    _bloc = BlocProvider.of<AuthenticationBloc>(context);
    fillList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return list();
  }

  void fillList() {
    _list = [
      _Directory(
        Text('個人資料'),
        () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonalInfoReview(),
            ),
          )
        },
      ),
//      _Directory(
//        Text('變更密碼'),
//        () => {
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => ForgotPasswordEmailPage(),
//            ),
//          )
//        },
//      ),
      _Directory(
        Text('聯絡我們'),
        () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactUs(),
            ),
          )
        },
      ),
      _Directory(
        Text('版本資訊'),
        () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VersionInfo(),
            ),
          )
        },
      ),
      _Directory(Text('登出'), () {
        BlocProvider.of<HomeBloc>(context).add(HomeEvent.init);
        _bloc.add(LoggedOut());
        if (Navigator.canPop(context))
          Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
      }),
    ];
  }

  Widget list() {
    return Container(
      height: 500,
      child: ListView.separated(
          itemBuilder: (context, int) => ListTile(
                title: _list[int].title,
                onTap: _list[int].function,
              ),
          separatorBuilder: (context, int) => Divider(),
          itemCount: _list.length),
    );
  }
}

class _Directory {
  Widget _title;
  Function _function;

  _Directory(this._title, this._function);

  _Directory.empty();

  Function get function => _function;

  set function(Function value) {
    _function = value;
  }

  Widget get title => _title;

  set title(Widget value) {
    _title = value;
  }
}
