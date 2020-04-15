import 'package:flutter/material.dart';

Future<Map> doubleSelection(
    BuildContext ctx, String title, int left, int right) async {
  num _left = left;
  num _right = right;
  bool _isDone = false;
  num height;
  await showModalBottomSheet(
    context: ctx,
    builder: (_ctx) => StatefulBuilder(
      builder: (ctx, state) => Container(
        height: 210,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 150,
                  width: 100,
                  child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    controller: PageController(
                        viewportFraction: 0.3, initialPage: left),
                    itemBuilder: (ctx, index) {
                      bool _ = _left == index;
                      return Text(
                        '$index',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(_ ? 1 : 0.3)),
                      );
                    },
                    onPageChanged: (index) {
                      _left = index;
                      state(() {});
                    },
                  ),
                ),
                Container(
                  height: 150,
                  width: 100,
                  child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    controller: PageController(
                        viewportFraction: 0.3, initialPage: right),
                    itemBuilder: (ctx, index) {
                      bool _ = _right == index;
                      return Text(
                        '$index',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(_ ? 1 : 0.3)),
                      );
                    },
                    onPageChanged: (index) {
                      _right = index;
                      state(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ),
  );
  return _isDone ? {'left': _left, 'right': _right} : null;
}