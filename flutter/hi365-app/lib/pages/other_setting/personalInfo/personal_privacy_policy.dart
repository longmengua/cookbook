import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:hi365/pages/authentication/authentication_bloc.dart';
import 'package:hi365/pages/authentication/authentication_event.dart';
import 'package:hi365/pages/home/home_bloc.dart';
import 'package:hi365/pages/iot/index.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_info1.dart';

import 'personal_info2.dart';

class PersonalPrivacyPolicy extends StatefulWidget {
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<PersonalPrivacyPolicy> {
  Future init;

  Future didSignPolicy() async {
    Future.delayed(Duration(seconds: 1));
    return false;
  }

  @override
  void initState() {
    super.initState();
    init = didSignPolicy();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init,
      builder: (ctx, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return BlocProvider.of<HomeBloc>(context).didSignPrivacyPolicy
                ? PersonalInfo1()
                : signPage();
            break;
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
          default:
            return Scaffold(
              body: loading(MediaQuery.of(context).size),
            );
        }
      },
    );
  }

  List<bool> agreement = [false, false];

  Widget signPage() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            HtmlWidget(
              BlocProvider.of<HomeBloc>(context).privacyPolicyPaper ??
                  '',
              textStyle: TextStyle(fontSize: 10),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  tristate: false,
                  value: agreement[0],
                  onChanged: (v) {
                    agreement[0] = v;
                    setState(() {});
                  },
                ),
                Expanded(
                  child: Text('本人已詳閱及瞭解上開注意事項並同意遵守。'),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  tristate: false,
                  value: agreement[1],
                  onChanged: (v) {
                    agreement[1] = v;
                    setState(() {});
                  },
                ),
                Expanded(
                  child: Text('本人同意Hi365得為了行銷目的使用及分享本人資訊。'),
                ),
              ],
            ),
            OutlineButton(
              child: Text('同意'),
              onPressed: !(agreement[0] && agreement[1])
                  ? null
                  : () {
                      BlocProvider.of<HomeBloc>(context)
                          .add(HomeEvent.signPrivacyPolicy);
                    },
            ),
            OutlineButton(
              child: Text('不同意'),
              onPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(HomeEvent.init);
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoggedOut());
                    },
            )
          ],
        ),
      ),
    );
  }
}
