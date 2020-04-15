import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:hi365/pages/dashboard/key_report/key_report_dto.dart';
import 'package:hi365/pages/dashboard/key_report/questionnaire.dart';

class KeyReport extends StatefulWidget {
  final KeyReportDTO _keyReportDTO;

  KeyReport(this._keyReportDTO, {Key key}) : super(key: key);

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<KeyReport> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _body(size);
  }

  Widget _body(size) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '關鍵報告',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            title(severity: widget?._keyReportDTO?.severity?.toLowerCase()),
            subTitle('定義/影響'),
            content(
              widget?._keyReportDTO?.definition ?? '--',
              widget?._keyReportDTO?.effect ?? '--',
            ),
            subTitle('判定規則'),
            content(widget?._keyReportDTO?.ruleDescription ?? '--'),
            subTitle('建議'),
            content(widget?._keyReportDTO?.sugMsg ?? '--'),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
//                  Text(
//                    '您的風險機率：70%，',
//                    style: TextStyle(fontSize: 17),
//                  ),
//                  InkWell(
//                    child: Text(
//                      '查看詳情',
//                      style: TextStyle(
//                        color: Color(0xff3B6D99),
//                        fontSize: 17,
//                      ),
//                    ),
//                  )
                ],
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
//      bottomNavigationBar: bottomNavBar(() {
//        Navigator.push(
//          context,
//          CupertinoPageRoute(
//            builder: (context) => Questionnaire(),
//          ),
//        );
//      }),
    );
  }

  Widget bottomNavBar([Function function]) {
    return Container(
      decoration: BoxDecoration(color: Color(0xffF9F9F9), border: Border.all()),
      padding: EdgeInsets.all(16),
      height: 80,
      child: Row(
        children: <Widget>[
          Text(
            '上次執行時間 2018-10-10',
            style: TextStyle(
              color: Color(0xff3B6D99),
              fontSize: 17,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                function();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff3B6D99),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  '選我評估',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget title({String severity}) {
    severity = severity?.toLowerCase();
    Map imagePaths = {
      'info': 'assets/keyreport/ic_info@2x.png',
      'warn': 'assets/keyreport/ic_warn@2x.png',
      'fatal': 'assets/keyreport/ic_fatal@2x.png',
      'error': 'assets/keyreport/ic_error@2x.png',
    };
    String bodyIcon;
    switch(widget?._keyReportDTO?.title){
      case '腦':
      case '腦中風':
        bodyIcon = 'assets/keyreport/ic_stroke@2x.png';
        break;
      case '呼吸系統':
        bodyIcon = 'assets/keyreport/ic_respiratorysystem@2x.png';break;
      case '冠心症':
        bodyIcon = 'assets/keyreport/ic_acs@2x.png';break;
      case '肝':
      case '肝癌':
        bodyIcon = 'assets/keyreport/ic_liver_disease@2x.png';break;
      case '過敏':
        bodyIcon = 'assets/keyreport/ic_allergy@2x.png';break;
      case '代謝功能':
        bodyIcon = 'assets/keyreport/ic_metabolicsyndrome@2x.png';break;
      case '腎':
        bodyIcon = 'assets/keyreport/ic_kidney_failure@2x.png';break;
      case '骨系統':
        bodyIcon = 'assets/keyreport/ic_bone_disease@2x.png';break;
      default:
    }
    return Container(
      margin: EdgeInsets.only(left: 16),
      height: 87,
      child: Row(
        children: <Widget>[
          Image.asset(
            bodyIcon ?? '',
            height: 56,
            width: 56,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(widget?._keyReportDTO?.ruleName ?? '--'),
                Row(
                  children: <Widget>[
                    Image.asset(
                      imagePaths[severity],
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget?._keyReportDTO?.description ?? '--',
                      style: TextStyle(color: Colors.black.withOpacity(0.3)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget subTitle(String _title) {
    return Center(
      child: Container(
        height: 44,
        padding: EdgeInsets.only(left: 16),
        color: Color(0xffEFEFF4),
        alignment: Alignment.centerLeft,
        child: Text(
          _title ?? '--',
          style: TextStyle(color: Color(0xff8A8A8F), fontSize: 17),
        ),
      ),
    );
  }

  Widget content([String content1, String content2]) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          HtmlWidget(
            content1 ?? '',
          ),
          HtmlWidget(
            content2 ?? '',
          ),
        ],
      ),
    );
  }
}
