import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'dart:io' as DeviceInfo;

class VersionInfo extends StatefulWidget {
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<VersionInfo> {
  String appName;
  String version;
  String buildNumber;
  String deviceName;
  String deviceVersion;

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo iosInfo;
  AndroidDeviceInfo androidInfo;

  _getDeviceInfo() async {
    if (DeviceInfo.Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      deviceName = '${androidInfo.model}';
      deviceVersion = 'Android ${androidInfo.version.release}';
    } else if (DeviceInfo.Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
      deviceName = '${iosInfo.model}';
      deviceVersion = '${iosInfo.systemName} ${iosInfo.systemVersion}';
    }
  }

  Future getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.packageName?.split('.')?.last ?? '';
    version = packageInfo.version ?? '';
//    buildNumber = packageInfo.buildNumber ?? '';
    return true;
  }

  @override
  void initState() {
    _getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: FutureBuilder(
        future: getVersionInfo(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return _body();
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
            default:
              return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
              child: Text(
            '版本編號',
            textAlign: TextAlign.center,
          )),
          Container(
            child: Text(
              '${version ?? '--'}',
//              '${version ?? '--'} + ${buildNumber ?? '--'}',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Text(
            '裝置名稱',
            textAlign: TextAlign.center,
          )),
          Container(
            child: Text(
              deviceName ?? '--',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Text(
            '系統版本',
            textAlign: TextAlign.center,
          )),
          Container(
            child: Text(
              deviceVersion ?? '--',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
        ],
      ),
    );
  }
}
