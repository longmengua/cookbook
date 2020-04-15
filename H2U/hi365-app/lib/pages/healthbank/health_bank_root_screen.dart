import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hi365/pages/healthbank/health_bank_new_screen.dart';
import 'package:hi365/pages/healthbank/health_bank_repository.dart';
import 'package:hi365/pages/healthbank/health_depo_screen.dart';
import 'package:logger/logger.dart';

class HealthBankRootScreen extends StatefulWidget {
  HealthBankRootScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HealthBankRootScreenState createState() => _HealthBankRootScreenState();
}
// https://juejin.im/post/5bfa9feee51d4524d9250689
class _HealthBankRootScreenState extends State<HealthBankRootScreen> {
  var logger = Logger(printer: PrettyPrinter());
  HealthBankRepository _healthBankRepository = new HealthBankRepository();
  Future future;

  @override
  void initState() {
    super.initState();
    future = getdata();
  }

  Future<int> getdata() async {
      int result =
          await _healthBankRepository.countMasterFile();
      return result;
  }

  Future refresh() async {
    setState(() {
      future = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        new Scaffold(
           body: buildFutureBuilder(),
        );
  }

  FutureBuilder<int> buildFutureBuilder() {
    return new FutureBuilder<int>(
      builder: (context, AsyncSnapshot<int> async) {
        if (async.connectionState == ConnectionState.active ||
            async.connectionState == ConnectionState.waiting) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
        if (async.connectionState == ConnectionState.done) {
          if (async.hasError) {
            return HealthBankNewScreen();
          } else if (async.hasData) {
            if (async.data > 0) {
              return new RefreshIndicator(
                  child: HealthDepoScreen(),
                  onRefresh: refresh);
              }
            } else {
            return new RefreshIndicator(
                child: HealthBankNewScreen(),
                onRefresh: refresh);
            }
          }
        return HealthBankNewScreen();
      },
      future: future,
    );
  }
}
