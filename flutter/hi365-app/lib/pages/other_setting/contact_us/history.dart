import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'contact_us_model.dart';
import 'contact_us_provider.dart';
import 'history_detail.dart';

class History extends StatefulWidget {
  final Map<String, String> _map;

  History(this._map);

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<History> {
  final ContactUsProvider _contactUsProvider = ContactUsProvider();

  List<ContactUsModel> history;

  Stream<List<ContactUsModel>> getHistory() async* {
    yield null;
    history = await _contactUsProvider.getContactUsInfo();
    yield history;
  }

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
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            '歷史紀錄',
            style: TextStyle(fontSize: 17),
          ),
        ),
        body: StreamBuilder<List<ContactUsModel>>(
          stream: getHistory(),
          builder: (context, snapshot) {
            Widget toReturn;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                toReturn = Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.done:
                if (snapshot.data == null || snapshot.data.length <= 0) {
                  toReturn = Center(
                    child: Column(
                      children: <Widget>[
                        Spacer(),
                        Container(
                          height: size.width * 0.8,
                          child: Image.asset(
                            'assets/reachUs/img_nodata@2x.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '無任何紀錄',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.4)),
                        ),
                        Spacer(),
                      ],
                    ),
                  );
                  break;
                }
                toReturn = Container(
                  margin: EdgeInsets.all(20),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: body(
                          dateTime: history[index].questionTime,
                          title: widget._map[history[index].questionType],
                          content: history[index].question,
                          isRespond: history[index].isRespond,
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                HistoryDetail(history[index], widget._map),
                          ));
                        },
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: history.length,
                  ),
                );
                break;
            }
            return toReturn;
          },
        ));
  }

  Widget body({String dateTime, String title, String content, bool isRespond}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          dateTime ?? DateTime.now().toString().substring(0, 16),
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            Text(
              title ?? 'title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            Opacity(
              opacity: isRespond ? 1.0 : 0.0,
              child: Image.asset(
                'assets/reachUs/ic_reply_table@2x.png',
                height: 14,
                width: 20,
              ),
            ),
            Spacer(),
            Opacity(
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              opacity: 0.4,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          content ?? 'content',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
