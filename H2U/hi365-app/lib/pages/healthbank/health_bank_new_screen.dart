import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hi365/pages/iot/index.dart';
import 'package:logger/logger.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

const String _pdfDocumentPath1 = 'assets/pdf/hrb_app_healthbook_auth.pdf';
const String _pdfDocumentPath2 = 'assets/pdf/hrb_app_healthbook_download.pdf';

class HealthBankNewScreen extends StatefulWidget {
  HealthBankNewScreen({Key key, this.title}) : super(key: key);
  final String title;

  static const MethodChannel methodChannel =
      MethodChannel('com.h2uclub.hi365/mhb');

  @override
  _HealthBankNewScreenState createState() => _HealthBankNewScreenState();
}

class _HealthBankNewScreenState extends State<HealthBankNewScreen> {
  static const MethodChannel methodChannel =
      MethodChannel('com.h2uclub.hi365/mhb');
  bool isLoading = false;

  var logger = Logger(printer: PrettyPrinter());

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getMHBoperation() async {
    print('>>> openingHealthBank');
    try {
      final Map<dynamic, dynamic> result =
          await methodChannel.invokeMethod('getMHBoperation');
      await _checkMHBFiles();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _checkMHBFiles() async {
    try {
      final Map<dynamic, dynamic> result =
          await methodChannel.invokeMethod('checkMHBFiles');
      logger.i("_checkMHBFiles  value:" + result.toString());
      String content = result['content'].toString();
    } on PlatformException {}
  }

  Future<String> preparePdf(String docpath) async {
    final ByteData bytes = await DefaultAssetBundle.of(context).load(docpath);
    final Uint8List list = bytes.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$docpath';
    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(children: <Widget>[
          Container(
            width: 377.0,
            height: 56.0,
            padding: new EdgeInsets.only(left: 20.0),
            child: new AutoSizeText('健康存摺',
                style: TextStyle(
                    color: Color.fromRGBO(17, 17, 17, 1),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 34)),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: 160.0,
            child: Image.asset(
                'assets/images/healthbank/img_healthbook_download.png',
                fit: BoxFit.fill),
          ),
          Center(
            child: InkWell(
              onTap: () {
                _getMHBoperation();
              },
              child: Container(
                width: 200,
                height: 44.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.all(Radius.circular(22.0))),
                child: Text(
                  '前往下載健康存摺',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: new AutoSizeText('申請健康存摺步驟說明',
                    style: TextStyle(
                        color: Color.fromRGBO(17, 17, 17, 1),
                        fontStyle: FontStyle.normal,
                        fontSize: 16)),
              ),
              Spacer(),
            ],
          ),
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border:
                  Border.all(color: Color.fromRGBO(255, 163, 0, 1), width: 1.0),
            ),
            child: ListTile(
              leading: Image.asset('assets/images/healthbank/ic_notice.png',
                  fit: BoxFit.cover),
              title: AutoSizeText(
                '事前準備',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(17, 17, 17, 1),
                ),
              ),
              subtitle: AutoSizeText(
                '請備妥健保卡與全民健保行動快易通App',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Color.fromRGBO(17, 17, 17, 1).withOpacity(0.54),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 1.0,
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xffECF7FF),
                        child: AutoSizeText(
                          '1',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: horizontalDivider(
                            height: 216.5,
                            color: Color(0xff111111).withOpacity(0.12)),
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xffECF7FF),
                        child: AutoSizeText(
                          '2',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: horizontalDivider(
                            height: 134.5,
                            color: Color(0xff111111).withOpacity(0.12)),
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xffECF7FF),
                        child: AutoSizeText(
                          '3',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: horizontalDivider(
                            height: 85.0,
                            color: Color(0xff111111).withOpacity(0.12)),
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xffECF7FF),
                        child: AutoSizeText(
                          '4',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  //decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    children: [
                      Container(
                        height: 223,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: AutoSizeText(
                                  '行動裝置認證',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(17, 17, 17, 1),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: AutoSizeText(
                                  '首次使用需至「全民健保行動快易通」App進行認證，認證結束，請記得回到H2U健康銀行執行後續動作。',
                                  style: TextStyle(
                                    color: Color.fromRGBO(17, 17, 17, 1)
                                        .withOpacity(0.54)
                                        .withOpacity(0.54),
                                  )),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      color: Color.fromRGBO(255, 105, 0, 1))),
                              child: ListTile(
                                  title: AutoSizeText('請參考健康存摺認證',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 105, 0, 1),
                                      )),
                                  trailing: Image.asset(
                                      'assets/images/healthbank/ic_nv_next_orange.png',
                                      fit: BoxFit.cover),
                                  onTap: () => {
                                        preparePdf(_pdfDocumentPath1)
                                            .then((path) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FullPdfViewerScreen(path)),
                                          );
                                        })
                                      }),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        height: 188,
                        child: Column(
                          children: <Widget>[
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: AutoSizeText(
                                  '健康存摺下載',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(17, 17, 17, 1),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: AutoSizeText(
                                  '請點選本畫面右上方的下載健康存摺按鈕。',
                                  style: TextStyle(
                                    color: Color.fromRGBO(17, 17, 17, 1)
                                        .withOpacity(0.54),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      color: Color.fromRGBO(255, 105, 0, 1))),
                              child: ListTile(
                                  title: AutoSizeText('下載健康存摺',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 105, 0, 1),
                                      )),
                                  trailing: Image.asset(
                                      'assets/images/healthbank/ic_nv_next_orange.png',
                                      fit: BoxFit.cover),
                                  onTap: () => {
                                        preparePdf(_pdfDocumentPath2)
                                            .then((path) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FullPdfViewerScreen(path)),
                                          );
                                        })
                                      }),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        height: 121,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: AutoSizeText(
                                  '健康存摺上傳',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(17, 17, 17, 1),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Align(
                                alignment: Alignment.center,
                                child: AutoSizeText('當健康存摺下載完成，系統會自行進行上傳的動作。',
                                    style: TextStyle(
                                      color: Color.fromRGBO(17, 17, 17, 1)
                                          .withOpacity(0.54),
                                    )),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: AutoSizeText(
                            '注意事項',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(17, 17, 17, 1),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: AutoSizeText(
                              '下載與上傳皆需費時處理，為避免操作失敗，建議勿在執行時關閉H2U健康銀行，煩請耐心等待。',
                              style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.54),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class FullPdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  FullPdfViewerScreen(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PDFViewerScaffold(appBar: AppBar(), path: pdfPath),
    );
  }
}
