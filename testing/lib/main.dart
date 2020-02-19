import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Board(),
    );
  }
}

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<Offset> black = [];
  List<Offset> white = [];
  bool current = true;
  bool isEndGame = false;
  String text = '';

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
    return Scaffold(
      appBar: AppBar(title: Text('Game Test')),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text(text, style: TextStyle(fontSize: 50)),
          ),
          Align(
            alignment: Alignment.center,
            child: CustomPaint(
              size: Size(300, 300), //指定画布大小
              painter: MyPainter(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: CustomPaint(
                  size: Size(300, 300),
                  painter: Painter(black, white),
                ),
              ),
              onPanDown: (DragDownDetails details) {
                if (isEndGame) return;
                placeStone(details);
                setState(() {});
                isEndGame = winCheck();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: OutlineButton(
              child: Text('重新開始'),
              onPressed: () {
                reStart();
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }

  reStart() {
    black = [];
    white = [];
    text = '';
    isEndGame = false;
  }

  bool winCheck() {
    return false;
  }

  placeStone(DragDownDetails details) {
    double dx = details.localPosition.dx;
    double dy = details.localPosition.dy;
    dx = dx % 20 <= 10 ? dx - dx % 20 : dx - dx % 20 + 20;
    dy = dy % 20 <= 10 ? dy - dy % 20 : dy - dy % 20 + 20;
    Offset offset = Offset(dx, dy);
    print(offset);

    ///to avoid placing in the same point.
    if (black.contains(offset) || white.contains(offset)) return;
    current ? black.add(offset) : white.add(offset);
    current = !current;
  }
}

class Painter extends CustomPainter {
  List<Offset> black;
  List<Offset> white;

  Painter(this.black, this.white);

  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;

    //画棋盘背景
    var paint = Paint();

    //画一个黑子
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    if (black.isNotEmpty)
      black.forEach((offset) {
        print(offset);
        canvas.drawCircle(offset, 9, paint);
      });

    //画一个白子
    paint.color = Colors.white;
    if (white.isNotEmpty)
      white.forEach((offset) {
        print(offset);
        canvas.drawCircle(offset, 9, paint);
      });
  }

  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;

    //画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb175); //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 15; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

//    //画一个黑子
//    paint
//      ..style = PaintingStyle.fill
//      ..color = Colors.black;
//    canvas.drawCircle(
//      Offset(size.width / 2 - eWidth / 2, size.height / 2 - eHeight / 2),
//      10,
//      paint,
//    );

//    //画一个白子
//    paint.color = Colors.white;
//    canvas.drawCircle(
//      Offset(size.width / 2 + eWidth / 2, size.height / 2 - eHeight / 2),
//      min(eWidth / 2, eHeight / 2) - 2,
//      paint,
//    );
  }

  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
