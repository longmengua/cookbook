import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hi365/pages/healthbank/healthbank_master_page.dart';

class HealthBankFilter extends StatefulWidget {
  final List<HealthBankMaster> masters;
  HealthBankFilter({Key key, this.masters}) : super(key: key);

  @override
  _HealthBankFilterState createState() => _HealthBankFilterState();
}

class _HealthBankFilterState extends State<HealthBankFilter> {
  final _formKey = GlobalKey<_HealthBankFilterState>();

  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Container(
            child: Builder(
                builder: (context) => Form(
                      key: _formKey,
                      child: Container(),
                    ))));
  }
}
