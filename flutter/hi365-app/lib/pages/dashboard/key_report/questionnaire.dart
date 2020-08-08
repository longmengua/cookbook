import 'package:flutter/material.dart';

const Space = SizedBox(
  height: 20,
  width: 20,
);

class Questionnaire extends StatefulWidget {
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('風險評估', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              title(),
              Space,
              content(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavBar(_showDialog),
    );
  }

  Widget title() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 19),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Color(0xff3B6D99),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '代謝症候群評估問卷',
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget content() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 19),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Text(
        '''Upcoming...''',
        style: TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }

  Widget bottomNavBar([Function function]) {
    return Container(
      decoration: BoxDecoration(color: Color(0xffF9F9F9), border: Border.all()),
      padding: EdgeInsets.all(16),
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                function();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff3B6D99),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  '送出',
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            "無法執行",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: Text(
                  '無法執行問卷，請再試一次。\n如果問題持續發生，\n請點選「聯絡我們」，反映問題。',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, height: 2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black.withOpacity(0.3)),
                          right:
                              BorderSide(color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                      child: InkWell(
                        child: new Text(
                          "聯絡我們",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff396C9B)),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                      child: InkWell(
                        child: new Text(
                          "再試一次",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff396C9B)),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
