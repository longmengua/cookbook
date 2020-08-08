import 'package:flutter/material.dart';

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