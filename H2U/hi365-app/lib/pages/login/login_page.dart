import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hi365/pages/authentication/authentication_bloc.dart';
import 'package:hi365/pages/authentication/index.dart';
import 'package:hi365/pages/login/index.dart';
import 'package:hi365/utils/app_configs.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          iconSize: 30.0,
          color: AppConfig().primaryColor,
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()),
        ),
        title: Text(
          "登入",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: LoginScreen(),
    );
  }
}
