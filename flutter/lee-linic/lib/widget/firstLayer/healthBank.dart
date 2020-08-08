import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app/description/dashbaordDescription.dart';
import 'package:app/description/healthBankDescription.dart';
import 'package:app/model/healthInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

import '../../home/homeBloc.dart';
import '../../home/homeEvent.dart';
import '../util/appBarFactory.dart';

class HealthBank extends StatefulWidget {
  @override
  _HealthBankState createState() => _HealthBankState();
}

class _HealthBankState extends State<HealthBank> {
  final String pdf1 = 'assets/pdf/hrb_app_healthbook_auth.pdf';
  final String pdf2 = 'assets/pdf/hrb_app_healthbook_download.pdf';
  final MethodChannel methodChannel = MethodChannel('com.h2uclub.hi365/mhb');
  Timer timer;
  bool isLoading = false;
  HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    methodChannel..setMethodCallHandler(handleMethod);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///build
    return Scaffold(
      appBar: AppBarFactory.custom(
        context: context,
        title: DashBoardDescription.list[2].title,
        leadingImagePath: DashBoardDescription.list[2].imagePath,
        trailingImagePath: DashBoardDescription.homeIcon,
        trailingImageOnTap: () async {
          homeBloc.add(HomeEvent.dashboard);
        },
      ),
      body: noData(),
    );
  }

  Widget test() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.deepOrange),
      child: FlatButton(
        child: Text(
          '讀取健康存摺',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          await methodChannel.invokeMethod('checkMHBFiles');
        },
      ),
    );
  }

  Widget noData() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20),
          header(homeBloc),
          instructionList(context),
        ],
      ),
    );
  }

  Widget header(HomeBloc homeBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.deepOrange),
          child: FlatButton(
            child: Text(
              HealthBankDescription.btn1,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await methodChannel.invokeMethod('getMHBoperation');
            },
          ),
        ),
        SizedBox(height: 20),
        test(),
        SizedBox(height: 20),
        Container(
          child: Text(
            HealthBankDescription.m0,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border:
                Border.all(color: Color.fromRGBO(255, 163, 0, 1), width: 1.0),
          ),
          child: ListTile(
            leading: Image.asset(
              'assets/images/ic_notice.png',
              fit: BoxFit.fill,
            ),
            title: Text(
              HealthBankDescription.m1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Color.fromRGBO(17, 17, 17, 1),
              ),
            ),
            subtitle: Text(
              HealthBankDescription.m2,
              style: TextStyle(
                fontSize: 10.0,
                color: Color.fromRGBO(17, 17, 17, 1).withOpacity(0.54),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget instructionList(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          stepBuilder(
            '1',
            HealthBankDescription.m3,
            HealthBankDescription.m4,
            widget: buttonBuilder(context, HealthBankDescription.btn2, pdf1),
          ),
          stepBuilder(
            '2',
            HealthBankDescription.m5,
            HealthBankDescription.m6,
            widget: buttonBuilder(context, HealthBankDescription.btn2, pdf2),
          ),
          stepBuilder(
            '3',
            HealthBankDescription.m7,
            HealthBankDescription.m8,
          ),
          stepBuilder(
            '4',
            HealthBankDescription.m9,
            HealthBankDescription.m10,
          ),
        ],
      ),
    );
  }

  Widget stepBuilder(String step, String title, String content,
      {Widget widget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xff4AB6F6),
              child: Text(
                step ?? '-',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(17, 17, 17, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
          padding: EdgeInsets.only(left: 25, top: 10, bottom: 10),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xff111111).withOpacity(0.12),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                content ?? '',
                style: TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1)
                      .withOpacity(0.54)
                      .withOpacity(0.54),
                ),
              ),
              Container(
                child: widget,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buttonBuilder(BuildContext context, String title, String pdfPath) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Color.fromRGBO(255, 105, 0, 1))),
      child: ListTile(
        title: Text(
          title ?? '',
          style: TextStyle(
            color: Color.fromRGBO(255, 105, 0, 1),
          ),
        ),
        trailing: Image.asset(
          'assets/images/ic_nv_next_orange.png',
          fit: BoxFit.cover,
        ),
        onTap: () {
          openPDF(pdfPath, context);
        },
      ),
    );
  }

  Future<String> preparePdf(String docPath, BuildContext context) async {
    final ByteData bytes = await DefaultAssetBundle.of(context).load(docPath);
    final Uint8List list = bytes.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$docPath';
    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }

  Future<void> openPDF(String docPath, BuildContext context) async {
    String path = await preparePdf(docPath, context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerScaffold(
          appBar: AppBar(),
          path: path,
        ),
      ),
    );
  }

  Future<dynamic> handleMethod(MethodCall call) async {
    switch (call.method) {
      case "UploadMHBJson":
        try {
          print(call.arguments['content']);
          homeBloc.bdata =
              HealthInfo.fromJson(jsonDecode(call.arguments['content']))
                  .myhealthbank
                  .bdata;
        } catch (e) {
          print(e);
        }
        return new Future.value("");
      case "Exit":
        timer = Timer.periodic(
          Duration(minutes: 1),
              (timer) async {
            print(DateTime.now());
            await methodChannel.invokeMethod('checkMHBFiles');
          },
        );
        return new Future.value("");
    }
  }
}
