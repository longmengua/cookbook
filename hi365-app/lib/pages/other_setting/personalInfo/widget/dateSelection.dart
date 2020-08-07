import 'package:flutter/material.dart';

Future<Map> dateSelection(BuildContext ctx, String title, num fromHour,
    num fromMinute, num toHour, num toMinute) async {
  num _fromHour = fromHour;
  num _fromMinute = fromMinute;
  num _toHour = toHour;
  num _toMinute = toMinute;
  bool _isDone = false;
  await showModalBottomSheet(
    context: ctx,
    builder: (_ctx) => StatefulBuilder(
      builder: (ctx, state) => Container(
        height: MediaQuery.of(_ctx).size.height * 0.4,
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      '取消',
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(_ctx).accentColor),
                    ),
                    onTap: () => Navigator.pop(_ctx),
                  ),
                  Text(title ?? '', style: TextStyle(fontSize: 20)),
                  GestureDetector(
                    child: Text(
                      '完成',
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(_ctx).accentColor),
                    ),
                    onTap: () {
                      _isDone = true;
                      Navigator.pop(_ctx);
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              children: <Widget>[
                Spacer(),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(_ctx).size.height * 0.02),
                  height: MediaQuery.of(_ctx).size.height * 0.25,
                  width: 50,
                  child: PageView.builder(
                    itemCount: 24,
                    scrollDirection: Axis.vertical,
                    controller: PageController(
                        viewportFraction: 0.2, initialPage: fromHour),
                    itemBuilder: (ctx, index) {
                      bool _ = _fromHour == index;
                      return Text(
                        '${index + 1}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(_ ? 1 : 0.3)),
                      );
                    },
                    onPageChanged: (index) {
                      _fromHour = index;
                      state(() {});
                    },
                  ),
                ),
                Container(
                  child: Text(
                    '時',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(_ctx).size.height * 0.02),
                  height: MediaQuery.of(_ctx).size.height * 0.25,
                  width: 50,
                  child: PageView.builder(
                    itemCount: 60,
                    scrollDirection: Axis.vertical,
                    controller: PageController(
                        viewportFraction: 0.2, initialPage: fromMinute),
                    itemBuilder: (ctx, index) {
                      bool _ = _fromMinute == index;
                      return Text(
                        '${index ?? ''}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(_ ? 1 : 0.3)),
                      );
                    },
                    onPageChanged: (index) {
                      _fromMinute = index;
                      state(() {});
                    },
                  ),
                ),
                Container(
                  child: Text(
                    '分',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(_ctx).size.height * 0.02),
                  height: MediaQuery.of(_ctx).size.height * 0.25,
                  width: 50,
                  child: PageView.builder(
                    itemCount: 24,
                    scrollDirection: Axis.vertical,
                    controller: PageController(
                        viewportFraction: 0.2, initialPage: toHour),
                    itemBuilder: (ctx, index) {
                      bool _ = _toHour == index;
                      return Text(
                        '${index + 1}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(_ ? 1 : 0.3)),
                      );
                    },
                    onPageChanged: (index) {
                      _toHour = index;
                      state(() {});
                    },
                  ),
                ),
                Container(
                  child: Text(
                    '時',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(_ctx).size.height * 0.02),
                  height: MediaQuery.of(_ctx).size.height * 0.25,
                  width: 50,
                  child: PageView.builder(
                    itemCount: 60,
                    scrollDirection: Axis.vertical,
                    controller: PageController(
                        viewportFraction: 0.2, initialPage: toMinute),
                    itemBuilder: (ctx, index) {
                      bool _ = _toMinute == index;
                      return Text(
                        '${index ?? ''}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(_ ? 1 : 0.3)),
                      );
                    },
                    onPageChanged: (index) {
                      _toMinute = index;
                      state(() {});
                    },
                  ),
                ),
                Container(
                  child: Text(
                    '分',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  return _isDone
      ? {
    'fromHour': _fromHour,
    'fromMinute': _fromMinute,
    'toHour': _toHour,
    'toMinute': _toMinute
  }
      : null;
}