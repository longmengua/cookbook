import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hi365/pages/home/index.dart';
import 'package:hi365/pages/online_consulting/online_consulting_model.dart';
import 'package:hi365/pages/online_consulting/online_consulting_provider.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_model.dart';
import 'package:hi365/utils/app_configs.dart';
import 'package:hi365/widgets/base_button.dart';
import 'package:hi365/widgets/text_form_field_builder.dart';
import 'package:intl/intl.dart';

class OnlineConsultingPage extends StatefulWidget {
  OnlineConsultingPage({Key key}) : super(key: key);

  @override
  _OnlineConsultingPageState createState() => _OnlineConsultingPageState();
}

class _OnlineConsultingPageState extends State<OnlineConsultingPage> {
  final String errMsgStoredKey = 'errMessage';
  final storage = new FlutterSecureStorage();
  TextEditingController _remainTimeController = TextEditingController();
  TextEditingController _expireDateController = TextEditingController();
  TextEditingController _currentCouponController = TextEditingController();
  TextEditingController _renewCouponController = TextEditingController();

  OnlineConsultingProvider _onlineConsultingProvider =
      OnlineConsultingProvider();

  static const _zoomChannel =
      const MethodChannel('com.h2uclub.hi365/join_meeting');

  PersonalModel _personalModel;

  Timer remainTimeGetter;

  bool isExpired;

  bool isActive;

  bool isLock = false;

  @override
  void initState() {
    super.initState();
    storage.delete(key: errMsgStoredKey);
    _personalModel = BlocProvider.of<HomeBloc>(context).personalModel;
    _getCouponStatus();
    remainTimeGetter =
        Timer.periodic(Duration(seconds: 5), (_) => _getCouponStatus());
  }

  @override
  void dispose() {
    remainTimeGetter.cancel();
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
          FlatButton(
            child: Text(
              '管理金鑰',
              style: TextStyle(color: AppConfig().primaryColor),
            ),
            onPressed: _openCouponDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showRemainTime(),
            _showExpireDate(),
            BaseButton(
              title: '開啟會議室',
              onPressed: isLock ? null : _launchMeeting,
            )
          ],
        ),
      ),
    );
  }

  Widget _showTitle() {
    return Container(
      child: InkWell(
        child: Text(
          '線上咨詢',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        onDoubleTap: () async {
          final errMsg = await storage.read(key: errMsgStoredKey);
          _showDialog(errMsg, null);
        },
      ),
    );
  }

  Widget _showRemainTime() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: TextFormFieldBuilder(
        isReadOnly: true,
        labelText: '剩餘通話時間(秒)',
        hintText: '尚未註冊金鑰',
        controller: _remainTimeController,
        validateFailureMessage: null,
      ),
    );
  }

  Widget _showExpireDate() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: TextFormFieldBuilder(
        isReadOnly: true,
        labelText: '有效日期',
        hintText: '尚未註冊金鑰',
        controller: _expireDateController,
        validateFailureMessage: null,
      ),
    );
  }

  void _launchMeeting() async {
    try {
      if (_remainTimeController.text.isEmpty ||
          int.parse(_remainTimeController.text) <= 0) {
        return _showDialog('通話時間不足，是否前往加值?', _openCouponDialog);
      }

      if (isExpired || !isActive) {
        return _showDialog('金鑰已失效!', _openCouponDialog);
      }
      lockJoinButton();

      OnlineConsultingRoom ocr = await _onlineConsultingProvider.getRoom();
      if (ocr == null || ocr.connectionToken == null) {
        unlockJoinButton();
        return _showDialog('服務人員忙線中，請稍候再試!', null);
      }

      await _onlineConsultingProvider.startDial(
        _personalModel.govId,
        _currentCouponController.text,
      );

      await _onlineConsultingProvider.sendGovID(
        ocr.connectionToken,
        _personalModel.govId,
      );

      unlockJoinButton();

      await _zoomChannel.invokeMethod('joinMeeting', ocr.pmi);
    } on DioError catch (e) {
      unlockJoinButton();
      storage.write(key: errMsgStoredKey, value: e.toString());
      _showDialog('服務人員忙線中，請稍候再試!', null);
    }
  }

  void lockJoinButton() {
    setState(() {
      isLock = true;
    });
  }

  void unlockJoinButton() {
    setState(() {
      isLock = false;
    });
  }

  Future<void> _openCouponDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('金鑰管理'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _showCurrentCouponField(),
                SizedBox(
                  height: 20,
                ),
                _showRenewCouponField(),
              ],
            ),
          ),
          actions: <Widget>[
            BaseButton(
              title: '取消',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            BaseButton(
              title: '更新',
              onPressed: () => setState(() =>
                  _renewCouponController.text.isNotEmpty
                      ? _registerCoupon()
                      : null),
            ),
          ],
        );
      },
    );
  }

  Widget _showCurrentCouponField() {
    return Row(
      children: <Widget>[
        Text('目前金鑰: '),
        Text(_currentCouponController.text),
      ],
    );
  }

  Widget _showRenewCouponField() {
    return TextFormFieldBuilder(
      labelText: '更新金鑰',
      hintText: '請輸入新的金鑰',
      validateFailureMessage: null,
      controller: _renewCouponController,
    );
  }

  _registerCoupon() async {
    try {
      OnlineConsulting _oc =
          await _onlineConsultingProvider.bindCouponWithGovId(
        _personalModel.govId,
        _renewCouponController.text,
      );
      // store key at local
      await storage.write(key: 'zoomKey', value: _oc.key);
      setState(() {
        _currentCouponController.text = _oc.key;
        _remainTimeController.text = _oc.remainTime.toString();
        _expireDateController.text = DateFormat('y-MM-dd')
            .format(DateTime.fromMillisecondsSinceEpoch(_oc.expirationDate));
        _renewCouponController.text = '';
        Navigator.of(context).pop();
      });
    } catch (e) {
      print('Regist Key failed: $e');
    }
  }

  _getCouponStatus() async {
    String key = await storage.read(key: 'zoomKey');
    List<OnlineConsulting> ocs =
        await _onlineConsultingProvider.getCouponByGovId(_personalModel.govId);
    ocs.forEach((oc) {
      if (oc.key == key) {
        DateTime expirationDate =
            DateTime.fromMillisecondsSinceEpoch(oc.expirationDate);
        String displayedDate = DateFormat('y-MM-d').format(expirationDate);
        _currentCouponController.text = key;
        _remainTimeController.text = oc.remainTime.toString();
        isExpired = DateTime.now().isAfter(expirationDate);
        _expireDateController.text =
            isExpired ? '$displayedDate(已到期)' : displayedDate;
        isActive = oc.active;
      }
    });
  }

  Future _showDialog(
    String content,
    Function callback,
  ) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            "開啟會議室失敗",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: Text(
                  content ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, height: 2),
                ),
              ),
              callback != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 11),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: Colors.black.withOpacity(0.3)),
                                right: BorderSide(
                                    color: Colors.black.withOpacity(0.3)),
                              ),
                            ),
                            child: GestureDetector(
                              child: new Text(
                                "取消",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xff396C9B)),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 11),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: Colors.black.withOpacity(0.3)),
                              ),
                            ),
                            child: GestureDetector(
                              child: new Text(
                                "前往",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xff396C9B)),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                callback();
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 11),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  color: Colors.black.withOpacity(0.3)),
                            ),
                          ),
                          child: GestureDetector(
                            child: new Text(
                              "確定",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xff396C9B)),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}
