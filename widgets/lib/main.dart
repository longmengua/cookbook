import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets/screen/android/AndroidStyleApp.dart';
import 'package:widgets/screen/ios/IosStyleApp.dart';

///@author Waltor
///@at 02.13.2020
///@note
const num launchIndex = 0;

void main() => runApp(launchIndex == 0 ? AndroidStyleApp() : IosStyleApp());