import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///@author Waltor
///@at 02.13.2020
///@note
const num launchIndex = 0;

void main() => runApp(launchIndex == 0 ? AndroidStyleApp() : IosStyleApp());

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
      home: Scaffold(
        appBar: AppBar(),
        body: Text('----'),
      ),
      //routes -> The application's top-level routing table. [...]
//      routes: {
//        '/home':(BuildContext context) => HomePage(),
//        '/home/one':(BuildContext context) => OnePage(),
//        //....
//      },
      //initialRoute -> The name of the first route to show, if a Navigator is built. [...]
//      initialRoute: '/home/one',
      //onGenerateRoute ->The route generator callback used when the app is navigated to a named route. [...]
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
      //onUnknownRoute -> same as onGenerateRoute, but called when onGenerateRoute fails to generate a route, except for the initialRoute. [...].
//      onUnknownRoute: (setting) {
//        return PageRouteBuilder();
//      },
      //navigatorObservers->The list of observers for the Navigator created for this app. [...]
//      navigatorObservers: [
//        MyObserver(),
//      ],
      //title -> A one-line description used by the device to identify the app for the user. [...]
//      title: "切換ＡＰＰ顯示名字",
      //onGenerateTitle -> If non-null this callback function is called to produce the app's title string, otherwise title is used. [...]
//      onGenerateTitle: (context) {
//        return 'Flutter应用';
//      },
    //locale -> The initial locale for this app's Localizations widget is based on this value. [...]
//        locale: Locale('yy','zh'),//Locale(String _languageCode, [String _countryCode])
//        localizationsDelegates:,
    );
  }
}

class IosStyleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route previousRoute) {
    // callBack where do Navigator.push
    super.didPush(route, previousRoute);
    //get content by route.settings
    //route.currentResult
    print(route.settings.name);
  }
}

class MyLocalizationsDelegates extends LocalizationsDelegate
<MaterialLocalizations>{
  @override
  bool isSupported(Locale locale) {
    if(locale == const Locale('zh','cn')){
      return true;
    }
    return false;
  }
  @override
  bool shouldReload(LocalizationsDelegate old)  => false;

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    return new SynchronousFuture(new MyLocalizations(locale));
  }
}

class MyLocalizations extends DefaultMaterialLocalizations{
  final Locale locale;
  MyLocalizations(this.locale, );
  @override
  String get okButtonLabel {
    if(locale == const Locale('zh','cn')){
      return '好的';
    }else{
      return super.okButtonLabel;
    }
  }
  @override
  String get backButtonTooltip {
    if(locale == const Locale('zh','cn')){
      return '返回';
    }else{
      return super.okButtonLabel;
    }
  }
}