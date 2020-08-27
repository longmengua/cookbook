import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:widgets/config/appLocalization.dart';
import 'package:widgets/config/displayOption.dart';

///@author Waltor
///@at 02.13.2020
///@note
class AndroidStyleApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    ///@see https://juejin.im/post/5b5ed06b5188251aa30c790c
    return MaterialApp(
      //navigatorKey -> A key to use when building the Navigator. [...]
      //navigatorKey.currentState = Navigator.of(context)
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      //Turns on checkerboarding of layers rendered to offscreen bitmaps.
      checkerboardOffscreenLayers: true,
      //home -> The widget for the default route of the app (Navigator.defaultRouteName, which is /). [...]
      home: DemoApp(),

      ///routes -> The application's top-level routing table. [...]
//      routes: {
//        '/home':(BuildContext context) => HomePage(),
//        '/home/one':(BuildContext context) => OnePage(),
//        //....
//      },
      ///initialRoute -> The name of the first route to show, if a Navigator is built. [...]
//      initialRoute: '/home/one',
      ///onGenerateRoute ->The route generator callback used when the app is navigated to a named route. [...]
//      onGenerateRoute: (setting) {
//        //setting.isInitialRoute; initial route.
//        //setting.name; the key of the route name to redirect.
//        return new PageRouteBuilder(
//          pageBuilder: (BuildContext context, _, __) {
//            return HomePage();
//          },
//          opaque: false,
//          transitionDuration: new Duration(milliseconds: 200),
//          transitionsBuilder:
//              (___, Animation<double> animation, ____, Widget child) {
//            return new FadeTransition(
//              opacity: animation,
//              child: new ScaleTransition(
//                scale:
//                    new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
//                child: child,
//              ),
//            );
//          },
//        );
//      },
      ///onUnknownRoute -> same as onGenerateRoute, but called when onGenerateRoute fails to generate a route, except for the initialRoute. [...].
//      onUnknownRoute: (setting) {
//        return PageRouteBuilder();
//      },
      ///navigatorObservers->The list of observers for the Navigator created for this app. [...]
//      navigatorObservers: [
//        MyObserver(),
//      ],
      ///title -> A one-line description used by the device to identify the app for the user. [...]
//      title: "切換ＡＰＰ顯示名字",
      ///onGenerateTitle -> If non-null this callback function is called to produce the app's title string, otherwise title is used. [...]
//      onGenerateTitle: (context) {
//        return 'Flutter应用';
//      },
      ///locale -> The initial locale for this app's Localizations widget is based on this value. [...]
      locale: Locale('en', ""),
      //Locale(String _languageCode, [String _countryCode])
      ///localizationsDelegates -> The most important thing to implement i18n
      onGenerateTitle: (BuildContext context) =>
          DemoLocalizations.of(context).title,
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        LocaleNamesLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
      ],
    );
  }
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).title),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: LanguageOptions(),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
