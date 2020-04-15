import 'package:flutter/material.dart';
import 'package:hi365/pages/healthbank/health_bank_new_screen.dart';
import 'package:hi365/pages/healthbank/health_bank_provider.dart';
import 'package:hi365/pages/healthbank/healthbank_master_page.dart';
import 'package:hi365/widgets/list_healthbank_widget.dart';
import 'package:logger/logger.dart';

class HealthDepoScreen extends StatefulWidget {
  @override
  _HealthDepoScreenState createState() => _HealthDepoScreenState();
}

class _HealthDepoScreenState extends State<HealthDepoScreen>
    with SingleTickerProviderStateMixin {
  var logger = Logger(printer: PrettyPrinter());

  static final GlobalKey<_HealthDepoScreenState> scaffoldKey =
      new GlobalKey<_HealthDepoScreenState>();

  final HealthBankProvider _healthBankRepository = HealthBankProvider();
  Future _future;

  // https://github.com/flutter/flutter/issues/11426
  @override
  void initState() {
    super.initState();
    _future = _healthBankRepository.fetchHealthBank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Image.asset(
                  'assets/images/healthbank/ic_nv_download_orange.png',
                  fit: BoxFit.cover),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                            appBar: AppBar(
                              elevation: 0,
                            ),
                            body: HealthBankNewScreen(),
                          )),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<HealthBankMaster>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? ListViewHealthBank(masters: snapshot.data)
                    : Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
