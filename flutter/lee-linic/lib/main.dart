import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/appConfig.dart';
import 'config/chineseCupertinoLocalizations.dart';
import 'home/homeBloc.dart';
import 'home/homeView.dart';

void main() => runApp(Index());

class Index extends StatelessWidget {
  final List<BlocProvider> _blocProviders = [
    BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(context),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///take out the debug label of the right-top.
      debugShowCheckedModeBanner: false,

      ///If wanna lock the text font size, open the marked code.
//      builder: (context, child) {
//        return MediaQuery(
//          child: child,
//          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//        );
//      },

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
        Locale('zh', 'TW'),
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
      home: MultiBlocProvider(
        providers: _blocProviders,
        child: Scaffold(
          body: HomeView(),
        ),
      ),
      theme: ThemeData(
        ///@see https://github.com/flutter/flutter/issues/23239
        primarySwatch: AppConfig.white,
      ),
    );
  }
}
