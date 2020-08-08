import 'package:flutter/material.dart';
import 'package:hi365/utils/app_configs.dart';

import 'bloc/bloc.dart';
import 'checkup_download_screen.dart';

class CheckupDownloadPage extends StatelessWidget {
  static const String routeName = "/checkupDownload";

  const CheckupDownloadPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckupDownloadBloc _checkupDownloadBloc = CheckupDownloadBloc();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "下載健檢報告",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.delete_sweep,
            color: AppConfig().primaryColor,
            size: 30,
          ),
          onPressed: () => _checkupDownloadBloc.add(ClearInputs()),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: AppConfig().primaryColor,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: CheckupDownloadScreen(
        checkupDownloadBloc: _checkupDownloadBloc,
      ),
    );
  }
}
