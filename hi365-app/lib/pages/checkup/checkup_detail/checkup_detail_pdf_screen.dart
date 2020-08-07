import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:hi365/pages/checkup/checkup_model.dart';
import 'package:hi365/pages/iot/index.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class CheckupDetailPDFScreen extends StatefulWidget {
  final HealthCheckReportAttach healthCheckReportAttach;
  final String dateString;
  final String identifier;

  CheckupDetailPDFScreen(
      this.healthCheckReportAttach, this.dateString, this.identifier);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CheckupDetailPDFScreen> {
  Future init;

  @override
  void initState() {
    init = getFileFromUrl(widget?.healthCheckReportAttach, widget?.dateString,
        widget?.identifier);
    super.initState();
  }

  @override
  void dispose() {
    init = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: init,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            appBar: _appBar('讀取PDF中，請稍候...', 18),
            body: loading(size),
          );
        }
        if (snapshot.data == null) {
          return Scaffold(
            appBar: _appBar(),
            body: Center(
              child: Text(
                '連線異常，ＰＤＦ下載失敗。',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
        return PDFViewerScaffold(
            appBar: _appBar(widget?.healthCheckReportAttach?.description),
            path: snapshot.data);
      },
    );
  }

  AppBar _appBar([String title, double size]) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).accentColor,
          size: 30,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title ?? '',
        style: TextStyle(fontSize: size ?? 20),
      ),
    );
  }

  ///In order to avoid downloading the duplicate file, the path should have the identity value and date.
  Future getFileFromUrl(HealthCheckReportAttach healthCheckReportAttach,
      String dateString, String identifier) async {
    Stopwatch stopwatch = new Stopwatch()..start();
    String url = healthCheckReportAttach?.url;
    String description = healthCheckReportAttach?.description ?? '';
    String path;
    identifier = identifier ?? 'unKnow';
    File file;
    try {
      print(url);
      Directory dir = await getApplicationDocumentsDirectory();
      path = "${dir.path}/$identifier\_$dateString\_$description.pdf";
      print('The PDF path is \n\t"$path"');
      if (await File(path).exists()) {
        ///The testing result of the empty pdf size is 932 by using File(path).readAsBytesSync().length to get.
        print('The PDF has downloaded.');
        if (File(path).readAsBytesSync().length > 1000) {
          print('The PDF is not empty.');
          return path;
        } else {
          print('The PDF is empty, and start deleting it.');
          File(path).deleteSync(recursive: true);
        }
      }
      print('Start to download pdf file.');
      Uint8List bytes = await get(url).then((v) => v.bodyBytes);
      file = await File(path).create(recursive: true);
      await file.writeAsBytes(bytes);
      print('The PDF file has done the downloading for ${stopwatch.elapsed}.');
      stopwatch.stop();
      if (File(path).readAsBytesSync().length < 1000) {
        throw Exception('The PDF downloading failed');
      }
      return path;
    } catch (e) {
      print(e);
    }
  }
}
