import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hi365/pages/home/home_page.dart';

import 'personal_info5.dart';

class PersonalInfo4 extends StatefulWidget {
  final Map<String, dynamic> basicInfo;

  PersonalInfo4(this.basicInfo);

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<PersonalInfo4> {
  num _weight = 60;

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
        actions: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              child: Align(
                alignment: Alignment.center,
                child: Text('下一步',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              onTap: () {
                widget.basicInfo.update('weight', (old) => _weight?.toString(),
                    ifAbsent: () => _weight?.toString());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalInfo5(widget.basicInfo),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: inputMeasureInfo(size),
    );
  }

  Widget inputMeasureInfo(Size size) {
    return Builder(
      builder: (context) => InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * 0.1,
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  '請輸入您的體重',
                  style: TextStyle(
                      fontSize: 16, color: Colors.black.withOpacity(0.3)),
                ),
              ),
              pointer(size),
              weight(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget pointer(Size size) {
    return Container(
      alignment: Alignment.center,
      child: Column(children: <Widget>[
        Text(
          '$_weight 公斤',
          style: TextStyle(fontSize: 40),
        ),
        Container(
          margin: EdgeInsets.only(top: 0),
          width: 3,
          height: size.height * 0.2,
          color: Theme.of(context).accentColor,
        ),
      ],),
    );
  }

  Widget weight(Size size) {
    return Container(
      height: 100,
      width: (size.width - 40),
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: PageController(viewportFraction: 0.2, initialPage: _weight),
        itemBuilder: (ctx, index) {
          bool _ = index == _weight;
          List<Widget> toReturn = [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              color: Colors.black.withOpacity(0.3),
              height: index % 5 == 0 ? 40 : 20,
              width: 2,
            ),
            Container(
              child: Text(
                index % 5 == 0 ? '$index' : '',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.black.withOpacity(0.3)),
              ),
            )
          ];
          return Column(textDirection: TextDirection.rtl, children: toReturn);
        },
        onPageChanged: (value) {
          _weight = value;
          setState(() {});
        },
      ),
    );
  }
}
