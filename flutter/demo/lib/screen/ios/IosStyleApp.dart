import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///@author Waltor
///@at 02.13.2020
///@note
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
