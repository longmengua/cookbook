import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_review.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_update.dart';
import 'package:hi365/pages/personal_info/index.dart';
import 'package:hi365/pages/personal_info/personal_info_page.dart';
import 'package:hi365/utils/app_configs.dart';
import 'package:hi365/utils/snackbars.dart';

import 'checkup_detail/checkup_detail_screen.dart';
import 'checkup_download/checkup_download_page.dart';
import 'checkup_master/checkup_master_screen.dart';
import 'checkup_no_data_screen.dart';
import 'index.dart';

class CheckupPage extends StatefulWidget {
  static const String routeName = "/checkup";

  @override
  _CheckupPageState createState() => _CheckupPageState();
}

class _CheckupPageState extends State<CheckupPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CheckupBloc>(context).add(LoadCheckup());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: _showTitle(),
        actions: <Widget>[
          IconButton(
            iconSize: 22.0,
            color: AppConfig().primaryColor,
            icon: Image.asset('assets/icons/cloud_download/cloud_download.png'),
            onPressed: () =>
                BlocProvider.of<CheckupBloc>(context).add(CheckPersonalInfo()),
          ),
        ],
      ),
      body: BlocListener<CheckupBloc, CheckupState>(
        listener: (context, currentState) {
          if (currentState is ErrorCheckupState) {
            SnackBarBuilder.showError(context, '連線異常，請稍後再試。');
          } else if (currentState is LoadingCheckup) {
            SnackBarBuilder.showLoading(context, '資料讀取中...');
          } else if (currentState is IncompletePersonalInfo) {
            _goToPersonalInfoPage();
          } else if (currentState is CompletePersonalInfo) {
            _goToCheckouDownloadPage();
          }
        },
        child: BlocBuilder<CheckupBloc, CheckupState>(
          builder: (context, currentState) {
            if (currentState is NoCheckupData) {
              return _showNoData();
            }
            return _showCheckupInfo();
          },
        ),
      ),
    );
  }

  void _goToPersonalInfoPage() async {
    Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text(
          '目前尚無身分證資料，請前往個人資料頁面輸入身分證資料，點選『 確認 』後將自動導向。',
        ),
        action: SnackBarAction(
          label: '確認',
          textColor: Theme.of(context).accentColor.withOpacity(0.5),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PersonalInfoReview(),
              ),
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PersonalInfoUpdate(),
              ),
            );
          },
        )));
  }

  void _goToCheckouDownloadPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CheckupDownloadPage(),
      ),
    );
  }

  Widget _showCheckupInfo() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          CheckupMasterScreen(),
          CheckupDetailScreen(),
        ],
      ),
    );
  }

  Widget _showNoData() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(0x4a, 0x90, 0xe2, 1),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: <Widget>[
                Spacer(),
                Text(
                  '請點選',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                Image.asset('assets/images/healthbank/ic_toast_download.png'),
                Text(
                  '進行健檢報告的下載與上傳動作。',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          CheckupNoDataScreen(),
        ],
      ),
    );
  }

  Widget _showTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        '健檢報告',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
