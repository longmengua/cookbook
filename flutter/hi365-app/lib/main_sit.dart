import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hi365/pages/authentication/authentication_page.dart';
import 'package:hi365/pages/authentication/index.dart';
import 'package:hi365/pages/checkup/checkup_bloc.dart';
import 'package:hi365/pages/checkup/checkup_detail/bloc/bloc.dart';
import 'package:hi365/pages/checkup/checkup_master/bloc/bloc.dart';
import 'package:hi365/pages/home/home_bloc.dart';
import 'package:hi365/pages/login/index.dart';
import 'package:hi365/utils/ChineseCupertinoLocalizations.dart';
import 'package:hi365/utils/app_bloc_delegate.dart';
import 'package:hi365/utils/app_configs.dart';

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();

  List<BlocProvider> _blocProviders = [
    BlocProvider<AuthenticationBloc>(
      builder: (context) => AuthenticationBloc(),
    ),
    BlocProvider<LoginBloc>(
      builder: (context) => LoginBloc(),
    ),
    BlocProvider<CheckupBloc>(
      builder: (context) => CheckupBloc(),
    ),
    BlocProvider<CheckupMasterBloc>(
      builder: (context) => CheckupMasterBloc(),
    ),
    BlocProvider<CheckupDetailBloc>(
      builder: (context) => CheckupDetailBloc(),
    ),
    BlocProvider<HomeBloc>(
      builder: (context) => HomeBloc(),
    ),
  ];

  AppConfig().setAppConfig(
    appEnvironment: AppEnvironment.SIT,
    baseUrl: 'http://10.57.105.27:3651',
  );

  runApp(
    MultiBlocProvider(
      providers: _blocProviders,
      child: Index(),
    ),
  );
}

class Index extends StatelessWidget {
  Index({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///The following codes of builder is for locking font size to avoid overflow situation.
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      theme: AppConfig().themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => AuthenticationPage(),
        LoginPage.routeName: (context) => LoginPage(),
      },

      ///@see https://www.kikt.top/posts/flutter/framework/cupertino-paste-tooltip/
      ///This is for solving the cutButtonLabel is null issue, which caused by localizationsDelegates in ios only.
      ///The simple is to implement a CupertinoLocalizations.
      localizationsDelegates: [
        ChineseCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'TW'),
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
    );
  }
}
