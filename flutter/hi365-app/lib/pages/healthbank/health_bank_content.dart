import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hi365/pages/healthbank/healthbank_master_page.dart';
import 'package:hi365/utils/health_bank_type_helper.dart';

class HealthBankContent extends StatefulWidget {
  final HealthBankMaster master;

  HealthBankContent({Key key, this.master}) : super(key: key);

  @override
  _HealthBankContentState createState() => _HealthBankContentState();
}

class _HealthBankContentState extends State<HealthBankContent> {
  Widget _teethDetailWidget(HealthBankDetail detail) {
    return new Container(
      padding: new EdgeInsets.only(left: 0.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: new Text(
              (detail.orderName).toString(),
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          ),
          Flexible(
            child: Container(
              padding: new EdgeInsets.only(left: 0.0),
              child: new Text(
                (detail.teethName).toString(),
                style: new TextStyle(
                    color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
              ),
            ),
          ),
          Flexible(
            child: new Text(
              (detail.totalCount).toString() +
                  '/' +
                  (detail.medDays).toString(),
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  Widget orderWidget(HealthBankDetail detail) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: new Text(
              (detail.orderName).toString(),
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          ),
          Flexible(
            child: new Text(
              (detail.totalCount).toString() +
                  '/' +
                  (detail.medDays).toString(),
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  Widget m012Widget(HealthBankDetail detail) {
    // 癌症篩檢
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: new Text(
              (detail.itemName).toString(),
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          ),
          Flexible(
            child: new Text(
              detail.beginDate + ' ' + detail.orderName + detail.itemValue,
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _checkingItemWidget(HealthBankDetail detail) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: new Text(
              (detail.orderName).toString(),
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          ),
          Flexible(
            child: new Text(
              (detail?.itemValue ?? '').toString() +
                  '/' +
                  (detail?.itemStd ?? '').toString(),
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _m002Widget(HealthBankDetail detail) {
    final orderBlock = new Container(
      padding: new EdgeInsets.only(left: 0.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            child: new Text(
              (detail.seq).toString(),
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          ),
          Flexible(
            child: new Text(
              detail?.beginDate ?? ' ',
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          ),
          Flexible(
            child: new Text(
              detail?.endDate ?? ' ',
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          ),
          Flexible(
            child: new Text(
              detail?.orderName ?? ' ',
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          ),
          Flexible(
            child: new Text(
              (detail?.totalCount).toString(),
              style: new TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16.0),
            ),
          )
        ],
      ),
    );
    return orderBlock;
  }

  Widget _healthBankDetailCard(HealthBankDetail detail, BuildContext context) {
    if (widget.master.type == 'M012') {
      return Card(
          child: Column(
        children: <Widget>[
          ListTile(
            title: m012Widget(detail),
            onTap: () => _onTapItem(context, detail),
          ),
        ],
      ));
    } else if (widget.master.type == 'M003') {
      return Card(
          child: Column(
        children: <Widget>[
          ListTile(
            title: _teethDetailWidget(detail),
            onTap: () => _onTapItem(context, detail),
          ),
        ],
      ));
    } else if (widget.master.type == 'M005') {
      return Card(
          child: Column(
        children: <Widget>[
          ListTile(
            title: _checkingItemWidget(detail),
            onTap: () => _onTapItem(context, detail),
          ),
        ],
      ));
    } else if (widget.master.type == 'M002') {
      return Card(
          child: Column(
        children: <Widget>[
          ListTile(
            title: _m002Widget(detail),
            onTap: () => _onTapItem(context, detail),
          ),
        ],
      ));
    } else {
      return Card(
          child: Column(
        children: <Widget>[
          ListTile(
            title: orderWidget(detail),
            onTap: () => _onTapItem(context, detail),
          ),
        ],
      ));
    }
  }

  Widget healthBankMainCard(HealthBankMaster master, BuildContext context) {
    return Container(
      width: 380.0,
      //height: 210.0,
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: new Card(
        color: Color.fromRGBO(236, 247, 255, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: new Container(
          padding: new EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('就醫日期',
                        style: new TextStyle(
                            color:
                                Color.fromRGBO(17, 17, 17, 1).withOpacity(0.54),
                            fontSize: 14)),
                    new Text(master.dataTime1 ?? '',
                        style: new TextStyle(
                            color: Color.fromRGBO(17, 17, 17, 1),
                            fontSize: 18)),
                    new Text('存摺類型',
                        style: new TextStyle(
                            color:
                                Color.fromRGBO(17, 17, 17, 1).withOpacity(0.54),
                            fontSize: 14)),
                    new Text(
                        HealthBankTypeHelper.typeMessageConvert(master.type),
                        style: new TextStyle(
                            color: Color.fromRGBO(17, 17, 17, 1),
                            fontSize: 18)),
                    new Text('醫療機構',
                        style: new TextStyle(
                            color:
                                Color.fromRGBO(17, 17, 17, 1).withOpacity(0.54),
                            fontSize: 14)),
                    new Text(master?.hospitalName ?? ' ',
                        style: new TextStyle(
                            color: Color.fromRGBO(17, 17, 17, 1), fontSize: 18))
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(85.0, 20.0, 10.0, 60.0),
                    child: Image.asset(
                        'assets/images/healthbank/ic_bankbook_m001_orange.png',
                        fit: BoxFit.cover),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //https://stackoverflow.com/questions/49986303/flutter-can-i-add-a-header-row-to-a-listview
  //https://inducesmile.com/google-flutter/how-to-add-a-section-header-row-to-a-listview-in-flutter/
  //https://www.jianshu.com/p/1039b7d97114
  //https://stackoverflow.com/questions/50530152/how-to-create-expandable-listview-in-flutter
  //https://juejin.im/post/5b72988651882560fd234502
  //https://www.jianshu.com/p/1039b7d97114
  Widget buildBottomListView() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.master.details.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return Center(
              child: _healthBankDetailCard(
                  widget.master.details[position], context));
        });
  }

  Widget buildM012ListView() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.master.details.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return Center(
              child: _healthBankDetailCard(
                  widget.master.details[position], context));
        });
  }

  List<Widget> _m006CenterBuilder(HealthBankDetail detail) {
    // 影像或病理檢驗(查)報告資料 detail 內容
    return [
      Container(
        height: 150,
        padding: new EdgeInsets.only(left: 40.0),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Text(detail?.itemValue ?? ' ',
              style: TextStyle(
                  color: Color.fromRGBO(17, 17, 17, 1), fontSize: 16)),
        ),
      ),
    ];
  }

  List<Widget> _centerListTileBuilder() {
    // 西醫或中醫門診
    String type = widget.master.type;
    if (type == 'M001' || type == 'M010') {
      return [
        Container(
          padding: new EdgeInsets.only(top: 15.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.amber[50],
                child: Row(
                  children: <Widget>[
                    Expanded(
                      //padding: new EdgeInsets.only(left: 8.0),
                      child: Text(
                        '診斷',
                        style: TextStyle(
                            color:
                                Color.fromRGBO(17, 17, 17, 1).withOpacity(0.38),
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 70.0,
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '[' +
                            widget.master.diseaseCode +
                            ']  ' +
                            widget.master.diseaseName,
                        style: TextStyle(
                            color:
                                Color.fromRGBO(17, 17, 17, 1).withOpacity(0.38),
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.amber[50],
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '醫囑名稱',
                        style: TextStyle(
                            color:
                                Color.fromRGBO(17, 17, 17, 1).withOpacity(0.38),
                            fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '數量/給藥日數',
                        style: TextStyle(
                            color:
                                Color.fromRGBO(17, 17, 17, 1).withOpacity(0.38),
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ];
    } else if (type == 'M003') {
      //牙醫
      return [
        new Container(
          padding: new EdgeInsets.only(top: 15.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: new EdgeInsets.only(left: 20.0),
                color: Colors.amber[50],
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text('診斷',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 16))),
                  ],
                ),
              ),
              Container(
                height: 70.0,
                padding: new EdgeInsets.only(left: 20.0),
                color: Colors.white,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text(
                            '[' +
                                widget.master.diseaseCode +
                                ']  ' +
                                widget.master.diseaseName,
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1),
                                fontSize: 20))),
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.only(left: 20.0),
                color: Colors.amber[50],
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text('醫囑名稱',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 16))),
                    new Expanded(
                        child: new Text('牙位',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 16))),
                    new Expanded(
                        child: new Text('數量/給藥日數',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 16))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ];
    } else if (type == 'M004' || type == 'M008' || type == 'M009') {
      // 過敏資料,器捐或安寧緩和醫療意願,預防接種
      return [
        new Container(
          padding: new EdgeInsets.only(top: 15.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.amber[50],
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text('診斷',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 20))),
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.white,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text(widget.master.otherName,
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1),
                                fontSize: 16))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ];
    } else if (type == 'M002') {
      // 住院資料
      return [
        new Container(
          padding: new EdgeInsets.only(top: 15.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.amber[50],
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text('出院日期',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 20))),
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.white,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text(widget.master.dataTime2 ?? ' ',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1),
                                fontSize: 20))),
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.amber[50],
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text('診斷',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 20))),
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.white,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text(
                            '[' +
                                widget.master.diseaseCode +
                                ']  ' +
                                widget.master.diseaseName,
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1),
                                fontSize: 20))),
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.amber[50],
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text('處置',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1),
                                fontSize: 20))),
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.white,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text(
                            '[' +
                                widget.master.procedureCode +
                                ']  ' +
                                widget.master.procedureName,
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1),
                                fontSize: 20))),
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.only(left: 10.0),
                color: Colors.amber[50],
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text('序號',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 13))),
                    new Expanded(
                        child: new Text('執行起日',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 13))),
                    new Expanded(
                        child: new Text('執行迄日',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 13))),
                    new Expanded(
                        child: new Text('醫囑名稱',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 13))),
                    new Expanded(
                        child: new Text('總量',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 13))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ];
    } else if (type == 'M005') {
      // 檢查結果與資料
      return [
        new Container(
          padding: new EdgeInsets.only(top: 15.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.amber[50],
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text('診斷',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 16))),
                    new Expanded(
                        child: new Text('結果值/參考值',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 16))),
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.amber[50],
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text(
                            '[' + widget.master.details[0].orderCode + ']',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 16))),
                    new Expanded(
                        child: new Text(widget.master.details[0].orderName,
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 16))),
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.only(left: 40.0),
                color: Colors.amber[50],
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                        child: new Text(widget.master.otherCode ?? ' ',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 16))),
                    new Expanded(
                        child: new Text(widget.master.otherName ?? ' ',
                            style: TextStyle(
                                color: Color.fromRGBO(17, 17, 17, 1)
                                    .withOpacity(0.38),
                                fontSize: 16))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ];
    } else if (type == 'M006') {
      // 影像或病理檢驗(查)報告資料
      if (null != widget.master.details) {
        return [
          new Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: new EdgeInsets.only(top: 15.0),
                  padding: new EdgeInsets.only(left: 40.0),
                  color: Colors.amber[50],
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                          child: new Text('診斷',
                              style: TextStyle(
                                  color: Color.fromRGBO(17, 17, 17, 1)
                                      .withOpacity(0.38),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20))),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  padding: new EdgeInsets.only(left: 40.0),
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                            child: new Text(
                                widget.master.details[0]?.orderCode ?? ' ',
                                style: TextStyle(
                                    color: Color.fromRGBO(17, 17, 17, 1)
                                        .withOpacity(0.38),
                                    fontSize: 20))),
                        new Expanded(
                            child: new Text(
                                widget.master.details[0]?.orderName ?? ' ',
                                style: TextStyle(
                                    color: Color.fromRGBO(17, 17, 17, 1)
                                        .withOpacity(0.38),
                                    fontSize: 20))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ];
      }
    }
  }

  List<Widget> _contentBuilder() {
    List<Widget> contentWidgets = [];
    var type = widget.master.type;
    if (type == 'M001' ||
        type == 'M010' ||
        type == 'M002' ||
        type == 'M003' ||
        type == 'M004' ||
        type == 'M005' ||
        type == 'M006' ||
        type == 'M008' ||
        type == 'M009') {
      contentWidgets..add(healthBankMainCard(widget.master, context));
    }

    if (type == 'M001' ||
        type == 'M010' ||
        type == 'M002' ||
        type == 'M003' ||
        type == 'M004' ||
        type == 'M005' ||
        type == 'M006' ||
        type == 'M008' ||
        type == 'M009') {
      contentWidgets..addAll(_centerListTileBuilder());
    }

    if (type == 'M006') {
      if (null != widget.master.details) {
        contentWidgets..addAll(_m006CenterBuilder(widget.master.details[0]));
      }
    }

    if (type == 'M001' ||
        type == 'M002' ||
        type == 'M010' ||
        type == 'M003' ||
        type == 'M005') {
      contentWidgets
        ..add(Expanded(
          child: SizedBox(child: buildBottomListView()),
        ));
    }
    if (widget.master.type == 'M012') {
      contentWidgets
        ..add(Expanded(
          child: SizedBox(child: buildM012ListView()),
        ));
    }

    return contentWidgets;
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('記錄內容'),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height - 30,
            child: Column(children: _contentBuilder())),
      ),
    );
  }

  void _onTapItem(BuildContext context, HealthBankDetail detail) {
    // TODO
  }
}
