import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:hi365/pages/healthknowledge/health_knowledge_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'health_knowledge_provider.dart';

class HealthKnowledgeScreenDetail extends StatefulWidget {
  final ResultData _resultData;

  HealthKnowledgeScreenDetail(this._resultData);

  @override
  State<StatefulWidget> createState() {
    return _State(_resultData);
  }
}

class _State extends State<HealthKnowledgeScreenDetail> {
  final ResultData _resultData;
  HealthKnowledgeApiProvider _healthKnowledgeApiProvider =
      HealthKnowledgeApiProvider();

  _State(this._resultData);

  @override
  void initState() {
    if (_resultData?.id != null) {
      _healthKnowledgeApiProvider.getDetail(_resultData.id).then((response) {
        if (response is HealthKnowledgeDB)
          _resultData.content = response.results[0].content;
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
//            Row(
//              children: <Widget>[
//                Text('標籤#\t',
//                    style: TextStyle(
//                      fontSize: 18,
//                      fontWeight: FontWeight.bold,
//                      color: Color(0xff6CBBB4),
//                    )),
//                Expanded(
//                  child: Text(_resultData.tagNames,
//                      style: TextStyle(fontSize: 18)),
//                ),
//              ],
//            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image(
                      image: NetworkImage(HealthKnowledgeApiProvider.domainUrl +
                          _resultData?.fileUrl),
                      fit: BoxFit.contain,
                    ),
                    Text(
                      _resultData.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Container(
                      child: Text(_resultData.subtitle,
                          style: TextStyle(fontSize: 18)),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff6CBBB4).withOpacity(0.3),
                      ),
                    ),
                    _resultData.content.length > 0
                        ? HtmlWidget(
                            _resultData.content,
                            onTapUrl: (_url) async {
                              print(_url);
                              if (await canLaunch(_url)) {
                                await launch(_url);
                              } else {
                                throw 'Could not launch $_url';
                              }
                            },
                          )
                        : Text('內容讀取中...'),
                  ],
                ),
              ),
            ),
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: _resultData.releaseTime?.substring(0, 10),
                  children: <TextSpan>[
                    TextSpan(text: _resultData.authorName),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
