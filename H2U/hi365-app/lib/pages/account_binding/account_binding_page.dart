import 'package:flutter/material.dart';
import 'package:hi365/pages/account_binding/index.dart';
import 'package:hi365/utils/app_configs.dart';

class AccountBindingPage extends StatelessWidget {
  static const String routeName = "/accountBinding";

  @override
  Widget build(BuildContext context) {
    var _accountBindingBloc = AccountBindingBloc();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "帳號綁定",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppConfig().primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: AccountBindingScreen(accountBindingBloc: _accountBindingBloc),
    );
  }
}
