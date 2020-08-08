import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/authentication/authentication_bloc.dart';
import 'package:hi365/pages/authentication/authentication_event.dart';
import 'package:hi365/pages/dashboard/dashboard_page.dart';
import 'package:hi365/pages/healthbank/health_bank_repository.dart';
import 'package:hi365/pages/home/home_bloc.dart';
import 'package:hi365/pages/iot/index.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_info1.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_model.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_privacy_policy.dart';
import 'package:hi365/pages/other_setting/personalInfo/widget/error.dart';
import 'package:logger/logger.dart';

import 'home_bloc.dart';
import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key) {
    methodChannel.setMethodCallHandler(_handleMethod);
  }

  static const String routeName = "/home";
  final logger = Logger(printer: PrettyPrinter());
  final String title;
  static const MethodChannel methodChannel =
      MethodChannel('com.h2uclub.hi365/mhb');

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "UploadMHBJson":
        _uploadMHB(call.arguments);
        return new Future.value("");
    }
  }

  HealthBankRepository _healthBankRepository = HealthBankRepository();

  Future<void> _uploadMHB(Map data) async {
    _healthBankRepository.uploadMHB(data);
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var logger = Logger(printer: PrettyPrinter());
  var cron = new Cron();

  static const MethodChannel methodChannel =
      MethodChannel('com.h2uclub.hi365/mhb');

  //This is for testing, when it need to be munitor
//  Map typeMap = {
//    'HealthType.HEART_RATE': '心率',
//    'HealthType.BLOOD_PRESSURE': '血壓',
//    'HealthType.STEP_COUNT': '步數',
//    'HealthType.SLEEP': '睡眠',
//    'HealthType.WEIGHT': '體重',
//    'HealthType.BLOOD_SUGAR': '血糖',
//  };

  ///read data from health kit.
  iot() async {
    await Channel.permissionsRequest();
    await Future.delayed(Duration(seconds: 5));
    Business business = Business();

    ///step 1. get current date, and fetch three months before now.
    ///step 2. (loop)after synchronization get the oldest date data,
    ///        and if the date is before 2019, then stop fetching.
    for (var type in HealthType.values) {
      DateTime oldestDataDate;
      DateTime dateFrom;
      DateTime dateTo;
      num durationDays = 60;

      ///fetch data with three month.
      dateFrom = new DateTime.now().subtract(Duration(days: 14));
      dateTo = new DateTime.now();
      try {
        print('#####$type[$dateFrom ~ $dateTo]');
//        yield '${typeMap[type.toString()]} (${dateFrom.toString().substring(0, 10)} ~ ${dateTo.toString().substring(0, 10)})';
        await business.fetchFromNativeApp(type, dateFrom, dateTo);

        ///get oldest data date, then fetch {durationDays} days before.
        oldestDataDate = await business.getLatestDateTime(type);
        print('#####oldestDataDate[$oldestDataDate]');
        dateTo = oldestDataDate ?? dateFrom;
        dateFrom = oldestDataDate?.subtract(Duration(days: durationDays)) ??
            dateFrom.subtract(Duration(days: durationDays));
        while (dateFrom.isAfter(DateTime(2019))) {
          print('#####$type[$dateFrom ~ $dateTo]');
//          yield '${typeMap[type.toString()]} (${dateFrom.toString().substring(0, 10)} ~ ${dateTo.toString().substring(0, 10)})';
          await business.fetchFromNativeApp(type, dateFrom, dateTo);
          dateTo = dateFrom;
          dateFrom = dateFrom?.subtract(Duration(days: durationDays));
        }
        dateFrom = DateTime(2019);
        print('#####$type[$dateFrom ~ $dateTo]');
//        yield '${typeMap[type.toString()]} (${dateFrom.toString().substring(0, 10)} ~ ${dateTo.toString().substring(0, 10)})';
        await business.fetchFromNativeApp(type, dateFrom, dateTo);
      } catch (e) {
        print('#####Exception($e)');
//        yield '發生錯誤。($e)';
      return '';
      }
    }
    return 'true';
  }

  Future<void> _checkMHBFiles() async {
    String checkFileResult;
    try {
      final Map<dynamic, dynamic> result =
          await methodChannel.invokeMethod('checkMHBFiles');
    } on PlatformException {
      checkFileResult = 'Failed to check File.';
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeEvent.dashboard);
    cron.schedule(new Schedule.parse('*/1 * * * *'), () async {
      _checkMHBFiles();
    });
  }

  @override
  void dispose() {
    try {
      BlocProvider.of<HomeBloc>(context).add(HomeEvent.init);
    } catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) {
        switch (state) {
          case HomeState.signPolicy:
            return PersonalPrivacyPolicy();
            break;
          case HomeState.error:
            return autoLogout();
            break;
          case HomeState.personal:
            return PersonalInfo1();
          case HomeState.dashboard:
            return DashboardPage(iot);
            break;
          case HomeState.init:
          default:
            return Scaffold(
              body: loading(MediaQuery.of(context).size),
            );
        }
      },
    );
  }

  Widget autoLogout() {
    Future.delayed(Duration(seconds: 3)).then(
      (v) => BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()),
    );
    return ErrorPage(title: "無法連線");
  }
}
