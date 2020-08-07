import 'package:flutter/material.dart';

Future<Map> singleSelection(BuildContext ctx, String title, num value, {num addend}) async {
  addend = addend ?? 1;
  num _value = value~/addend;
  bool _isDone = false;
  await showModalBottomSheet(
    context: ctx,
    builder: (_ctx) => StatefulBuilder(
      builder: (ctx, state) => Container(
        height: 210,
        child: Column(
          children: <Widget>[
            Container(
              height:  40,
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
                        viewportFraction: 0.3, initialPage: _value),
                    itemBuilder: (ctx, index) {
                      bool _ = _value == index;
                      return Text(
                        '${index*addend ?? ''}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(_ ? 1 : 0.3)),
                      );
                    },
                    onPageChanged: (index) {
                      _value = index;
                      state(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  return _isDone ? {'value': _value*addend} : null;
}