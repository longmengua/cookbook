import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/authentication/index.dart';
import 'package:hi365/pages/other_setting/version/version.dart';
import 'package:hi365/widgets/apple_sign_in_button.dart';
import 'package:hi365/widgets/base_button.dart';

import 'authentication_bloc.dart';

class ChoicesScreen extends StatefulWidget {
  const ChoicesScreen({Key key}) : super(key: key);

  @override
  _ChoicesScreenState createState() => _ChoicesScreenState();
}

class _ChoicesScreenState extends State<ChoicesScreen> {
  bool isSupportAppleSignIn = false;

  @override
  void initState() {
    super.initState();
    this._checkIfSupportAppleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash/splash.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                BaseButton(
                  title: '手機登入',
                  onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                      .add(GoToPhoneLoginPage()),
                ),
                SizedBox(height: 15.0),
                BaseButton(
                  title: '使用 Google 登入',
                  onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                      .add(SignInWithGoogle()),
                ),
                SizedBox(height: 15.0),
                _showAppleSignInButton(),
//                BaseButton(
//                  title: '一般登入',
//                  onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
//                      .add(GoToLoginPage()),
//                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: OutlineButton(
        child: Text(
          '版本資訊',
          style: TextStyle(color: Colors.grey),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VersionInfo(),
          ),
        ),
      ),
    );
  }

  Widget _showAppleSignInButton() {
    if (Platform.isIOS && isSupportAppleSignIn) {
      return AppleSignInButton(
        onPressed: () =>
            BlocProvider.of<AuthenticationBloc>(context).add(SignInWithApple()),
      );
    }
    return Container();
  }

  void _checkIfSupportAppleSignIn() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setState(() {
        isSupportAppleSignIn =
            int.parse(iosInfo.systemVersion.split('.')[0]) >= 13;
      });
    }
  }
}
