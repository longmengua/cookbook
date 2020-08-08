import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hi365/pages/checkup/checkup_model.dart';
import 'package:scalable_image/scalable_image.dart';

class CheckupDetailSubScreen extends StatefulWidget {
  final CheckupDetail checkupDetail;

  CheckupDetailSubScreen(this.checkupDetail);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CheckupDetailSubScreen> {
  List<ImageProvider> images = [];
  num _index = 0;

  @override
  void initState() {
    images = _images(widget?.checkupDetail?.healthCheckReportAttachList);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              children: <Widget>[
                Spacer(
                  flex: 4,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      widget?.checkupDetail?.checkItemName ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 3,
                ),
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          _imagePageable(_index),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ScalableImage(
                imageProvider: images[_index], dragSpeed: 4.0, maxScale: 16.0),
          ),
          Row(
            children: <Widget>[
              FlatButton(
                child: Image.asset(
                  'assets/checkup/ic_dicomarrow_pre@2x.png',
                  height: 30,
                  width: 30,
                ),
                onPressed: () {
                  if (_index <= 0) return;
                  print('pre');
                  _index--;
                  setState(() {});
                },
              ),
              Spacer(),
              FlatButton(
                child: Image.asset(
                  'assets/checkup/ic_dicomarrow_next@2x.png',
                  height: 30,
                  width: 30,
                ),
                onPressed: () {
                  if (_index >= (images.length - 1)) return;
                  print('next');
                  _index++;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imagePageable(num index) {
    return Center(
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF).withOpacity(0.12),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              '${_index + 1} / ${images.length}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ImageProvider> _images(List<HealthCheckReportAttach> images) {
    List<ImageProvider> toReturn = [];

    print(images);
    try {
      images.forEach(
        (v) {
          ///todo: Find a solution to catch up the internal error of flutter.
          NetworkImage networkImage = NetworkImage(v.url);
          toReturn.add(networkImage);
        },
      );
    } catch (e) {
      print(e);
    }

    return toReturn;
  }
}
