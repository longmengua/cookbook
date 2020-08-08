import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'personal_info4.dart';

class PersonalInfo3 extends StatefulWidget {
  final Map<String, dynamic> basicInfo;

  PersonalInfo3(this.basicInfo);

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<PersonalInfo3> {
  num _height = 170;

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
                widget.basicInfo
                    .update('height', (old) => _height?.toString(), ifAbsent: () => _height?.toString());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalInfo4(widget.basicInfo),
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
    return SingleChildScrollView(
      child: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.topCenter,
                child: Text(
                  '請輸入您的身高',
                  style: TextStyle(
                      fontSize: 16, color: Colors.black.withOpacity(0.3)),
                ),
              ),
              pointer(size),
              height(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget pointer(Size size) {
    return SizedBox(
      height: 1,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: size.height/2 > 300 ? 200 : 150,
            right: 0,
            child: Row(
              children: <Widget>[
                Text(
                  '$_height 公分',
                  style: TextStyle(fontSize: 40),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  height: 3,
                  width: size.width * 0.3,
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget height(Size size) {
    return Container(
      height: size.height/2 > 300 ? 450 : 350,
      child: PageView.builder(
        reverse: true,
        scrollDirection: Axis.vertical,
        controller:
            PageController(viewportFraction: 0.03, initialPage: _height),
        itemBuilder: (ctx, index) {
          bool _ = index == _height;
          List<Widget> toReturn = [
            Container(
              color: _
                  ? null
                  : Colors.black.withOpacity(0.3),
              width: index % 5 == 0 ? 40 : 20,
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              width: 70,
              child: Text(
                index % 5 == 0 ? '$index 公分' : '',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(0.3)),
              ),
            )
          ];
          return Row(textDirection: TextDirection.rtl, children: toReturn);
        },
        onPageChanged: (value) {
          _height = value;
          setState(() {});
        },
      ),
    );
  }
}
