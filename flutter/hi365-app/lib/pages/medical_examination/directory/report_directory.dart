import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ExamReportDirectory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('體檢進度查詢'),
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  _State createState() {
    // TODO: implement createState
    return _State();
  }
}

class _State extends State<_Body> {
  final msg01 = '所有健檢項目皆已完成';
  List fakeDate;

  void state() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return body(size);
  }

  Widget body(Size size) {
    return GestureDetector(
      ///to close the keyboard where tap other place.
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Spacer(),
                baseInfo(),
                Spacer(),
                qrCode(),
              ],
            ),
            barcode(),
            Row(
              children: <Widget>[
                button(state),
                Spacer(),
                clear(state),
              ],
            ),
            Divider(),
            content(data: fakeDate, size: size),
          ],
        ),
      ),
    );
  }

  Widget baseInfo() {
    List<Widget> children = [];
    children.add(
      Text(
        '名字',
        style: TextStyle(fontSize: 20),
      ),
    );
    children.add(Text(
      '1979/07/16',
      style: TextStyle(fontSize: 20),
    ));
    return Column(children: children);
  }

  ///Two-dimensional barcode
  Widget qrCode() {
    return Container(
      margin: EdgeInsets.all(5),
      child: Image.asset(
        'assets/images/qrcode.jpg',
        fit: BoxFit.contain,
        height: 150,
      ),
    );
  }

  ///One-dimensional barcode
  Widget barcode() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Image.asset(
        'assets/images/barcode.gif',
        fit: BoxFit.contain,
        height: 80,
      ),
    );
  }

  ///Detail of medical progress report
  Widget content({List data, Size size}) {
    List<Widget> children = [];
    if (data == null || data.length == 0) {
      children.add(Container(
        margin: EdgeInsets.only(top: 30),
        child: Text(
          msg01 ?? '',
          style: TextStyle(fontSize: 20),
        ),
      ));
    } else {
      data.forEach((v) {
        ///todo: change it to listTile would be more flexible.
        children.add(ListTile(
          leading: Text('${DateTime.now().toString().substring(0,10)}'),
          title: Text('$v'),
          subtitle: Text('discrption'),
        ));
      });
    }
    return Column(
      children: children,
    );
  }

  Widget button(Function state) {
    return OutlineButton(
      onPressed: () {
        fakeDate = updateList(fakeDate);
        state();
      },
      child: Text('toggle to show data.'),
    );
  }

  Widget clear(Function state) {
    return OutlineButton(
      onPressed: () {
        fakeDate = [];
        state();
      },
      child: Text('clear data.'),
    );
  }
}

List updateList(List list) {
  List toReturn = [];
  for (int i = 0; i < 10; i++) {
    toReturn.add('xxxx');
  }
  return toReturn;
}
