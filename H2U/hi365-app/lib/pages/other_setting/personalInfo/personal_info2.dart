import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'personal_info3.dart';

class PersonalInfo2 extends StatefulWidget {
  final Map<String, dynamic> basicInfo;

  PersonalInfo2(this.basicInfo);

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<PersonalInfo2> {
  Map _date = {
    'year': 1990,
    'month': 0,
    'day': 0
  }; //Except the year, others have to plus 1 to be real number.

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
                String time = DateTime(
                        _date['year'], _date['month'] + 1, _date['day'] + 1)
                    .toUtc()
                    .toString()
                    .replaceAll(' ', 'T');
                widget.basicInfo
                    .update('birthday', (old) => time, ifAbsent: () => time);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalInfo3(widget.basicInfo),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: inputBirthInfo(),
    );
  }

  Widget inputBirthInfo() {
    num width = MediaQuery.of(context).size.width;
    return Builder(
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.topCenter,
                child: Text(
                  '請輸入您的生日',
                  style: TextStyle(
                      fontSize: 16, color: Colors.black.withOpacity(0.3)),
                ),
              ),
              birthdayScroller(),
              Container(
                height: 1,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -110,
                      left: (width - 40) * 0.05,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                            bottom: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        height: 50,
                        width: 70,
                      ),
                    ),
                    Positioned(
                      top: -110,
                      left: (width - 40) * 0.35,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                            bottom: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        height: 50,
                        width: 70,
                      ),
                    ),
                    Positioned(
                      top: -110,
                      left: (width - 40) * 0.65,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                            bottom: BorderSide(
                                width: 1.0,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        height: 50,
                        width: 70,
                      ),
                    ),
                  ],
                  overflow: Overflow.visible,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget birthdayScroller() {
    Size size = MediaQuery.of(context).size;
    int days = _date == null || _date['year'] == null || _date['month'] == null
        ? 30
        : DateTime(_date['year'], _date['month'] + 2)
            .subtract(Duration(days: 1))
            .day;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 150,
          width: (size.width - 40) / 4,
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            controller: PageController(
                viewportFraction: 0.33, initialPage: _date['year']),
            itemBuilder: (ctx, index) {
              bool _ = index == _date['year'];
              return Text(
                '$index',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.black.withOpacity(_ ? 1 : 0.3)),
              );
            },
            onPageChanged: (index) {
              _date['year'] = index;
              setState(() {});
            },
          ),
        ),
        Container(
          height: 150,
          width: (size.width - 40) / 4,
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            controller: PageController(viewportFraction: 0.33, initialPage: 0),
            itemCount: 12,
            itemBuilder: (ctx, index) {
              bool _ = index == _date['month'];
              return Text(
                '${index + 1}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.black.withOpacity(_ ? 1 : 0.3)),
              );
            },
            onPageChanged: (index) {
              _date['month'] = index;
              setState(() {});
            },
          ),
        ),
        Container(
          height: 150,
          width: (size.width - 40) / 4,
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            controller: PageController(viewportFraction: 0.33, initialPage: 0, keepPage: false),
            itemCount: days,
            itemBuilder: (ctx, index) {
              bool _ = index == _date['day'];
              return Text(
                '${index + 1}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.black.withOpacity(_ ? 1 : 0.3)),
              );
            },
            onPageChanged: (index) {
              _date['day'] = index;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
