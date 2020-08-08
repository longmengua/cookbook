import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contact_us_model.dart';

class HistoryDetail extends StatelessWidget {
  final ContactUsModel _contactUsModel;
  final Map _map;
  final directory = ['問題類型', '聯絡E-mail', '聯絡電話', '提問內容', '回覆內容'];

  HistoryDetail(this._contactUsModel, this._map);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Text(''),
        title: Text(
          '詳細記錄',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            iconSize: 24,
            color: Theme.of(context).accentColor,
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    if (_contactUsModel?.questionTime != null)
      directory[3] = directory[3] + _contactUsModel.questionTime.toString();
    if (_contactUsModel?.answerTime != null)
      directory[4] = directory[4] + _contactUsModel.answerTime.toString();
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              directory[0],
              style: TextStyle(color: Colors.black.withOpacity(0.4)),
            ),
            Text(_map[_contactUsModel?.questionType] ?? '--', style: TextStyle()),
            Divider(),
            Text(
              directory[1],
              style: TextStyle(color: Colors.black.withOpacity(0.4)),
            ),
            Text(_contactUsModel?.contactEmail ?? '--', style: TextStyle()),
            Divider(),
            Text(
              directory[2],
              style: TextStyle(color: Colors.black.withOpacity(0.4)),
            ),
            Text(_contactUsModel?.contactPhone ?? '--', style: TextStyle()),
            Divider(),
            Text(
              directory[3],
              style: TextStyle(color: Colors.black.withOpacity(0.4)),
            ),
            Text(_contactUsModel?.question ?? '--', style: TextStyle()),
            Divider(),
            Text(
              directory[4],
              style: TextStyle(color: Colors.black.withOpacity(0.4)),
            ),
            Text(_contactUsModel?.answer ?? '--', style: TextStyle()),
            Divider(),
          ],
        ),
      ),
    );
  }
}
