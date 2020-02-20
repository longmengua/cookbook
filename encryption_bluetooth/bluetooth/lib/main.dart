import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
///@author Waltor
///@at 02.13.2020
///@note it only implements on ios os, the android hasn't done yet.
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  Set<String> scannedList;

  @override
  void initState() {
    platform.setMethodCallHandler(callBackMethod);
    scannedList = Set();
    super.initState();
  }

  Future<bool> callBackMethod(MethodCall call) async {
    try {
      switch (call.method) {
        case "callBack":
          print(call.arguments);
          scannedList.add(call.arguments);
          setState(() {});
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[]..addAll(scannedList.map((v) => Text(
          v,
          style: TextStyle(fontSize: 30),
        ))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await platform.invokeMethod('getBatteryLevel');
          print(result);
//          final result = await AesCbcPKCS5Padding.encryption(
//            key: "er6nzx10rz1000",
//            data: "10, 20, 30, 40, 50, 60, 70, 80, 90, 100",
//          );
//          showDialog(
//              context: context,
//              builder: (context) {
//                return new SimpleDialog(
//                  title: Text("test"),
//                  children: <Widget>[
//                    Text(result ?? '-'),
//                  ],
//                );
//              });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
