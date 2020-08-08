import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hi365/pages/authentication/index.dart';
import 'package:hi365/pages/register/index.dart';
import 'package:hi365/utils/app_configs.dart';

class RegisterPage extends StatelessWidget {
  static const String routeName = "/register";

  @override
  Widget build(BuildContext context) {
    var _registerBloc = RegisterBloc();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppConfig().primaryColor,
            size: 30,
          ),
          onPressed: () =>
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()),
        ),
        title: Text(
          "註冊",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: RegisterScreen(registerBloc: _registerBloc),
      resizeToAvoidBottomInset: true,
    );
  }
}
