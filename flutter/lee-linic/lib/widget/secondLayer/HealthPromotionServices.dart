import 'package:app/description/conclusionDescription.dart';
import 'package:app/description/healthPromotionServiceDescription.dart';
import 'package:app/home/homeBloc.dart';
import 'package:app/home/homeEvent.dart';
import 'package:app/model/healthInfo.dart';
import 'package:app/widget/util/ExpandBox.dart';
import 'package:app/widget/util/circlePoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../util/appBarFactory.dart';

class HealthPromotionService extends StatefulWidget {
  @override
  HealthPromotionServices createState() => HealthPromotionServices();
}

class HealthPromotionServices extends State<HealthPromotionService> {
  HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///build
    return Scaffold(
      appBar: AppBarFactory.custom(
        context: context,
        title: ConclusionDescription.list[4].title,
        leadingImagePath: ConclusionDescription.list[4].imagePath,
        trailingImagePath: ConclusionDescription.homeIcon,
        trailingImageOnTap: () async {
          homeBloc.add(HomeEvent.conclusion);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              expandBoxWrapper(
                homeBloc.bdata?.r10?.first?.r10,
                homeBloc.bdata.r10,
                table0,
                HealthPromotionServiceDescription.group0,
                HealthPromotionServiceDescription.noData0,
              ),
              SizedBox(height: 10),
              expandBoxWrapper(
                homeBloc.bdata?.r11?.first?.r11,
                homeBloc.bdata.r11,
                table1,
                HealthPromotionServiceDescription.group1,
                HealthPromotionServiceDescription.noData1,
              ),
              SizedBox(height: 10),
              expandBoxWrapper(
                homeBloc.bdata?.r4?.first?.r4,
                homeBloc.bdata.r4,
                table2,
                HealthPromotionServiceDescription.group2,
                HealthPromotionServiceDescription.noData2,
              ),
              SizedBox(height: 10),
              expandBoxWrapper(
                homeBloc.bdata?.r5?.first?.r5,
                homeBloc.bdata.r5,
                table3,
                HealthPromotionServiceDescription.group3,
                HealthPromotionServiceDescription.noData3,
              ),
              SizedBox(height: 10),
              expandBoxWrapper(
                homeBloc.bdata?.r6?.first?.r6,
                homeBloc.bdata.r6,
                table4,
                HealthPromotionServiceDescription.group4,
                HealthPromotionServiceDescription.noData4,
              ),
              SizedBox(height: 10),
              expandBoxWrapper(
                homeBloc.bdata?.r8?.first?.r8,
                homeBloc.bdata.r8,
                table5,
                HealthPromotionServiceDescription.group5,
                HealthPromotionServiceDescription.noData5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget expandBoxWrapper(
    String desc,
    List list,
    Widget Function(List list) table,
    String header,
    String noData,
  ) {
    //無資料時候顯示 //有點邏輯上問題，無資料時候，可能為null，也可能是“無資料”。
    if (desc != null) return noDataWidget(noData);
    //有資料時候顯示
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.purple.shade100,
      ),
      child: ExpandBox(
        Text(
          header,
          textAlign: TextAlign.center,
        ),
        table(list),
        CrossAxisAlignment.stretch,
      ),
    );
  }

  Widget noDataWidget(String noData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade400,
          ),
          child: Text(
            noData,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  //padding in common
  Widget padding(Widget addPadding) => Container(
        padding: EdgeInsets.all(10),
        child: addPadding,
      );

  ///---------------成人健檢資料---------------
  Widget table0(List list) {
    List<R10> r10 = list;
    List<TableRow> body = <TableRow>[];
    if (r10 != null && r10.isNotEmpty)
      r10.forEach((r10) {
        body.addAll(tableRowBuilder0(r10));
      });
    return Container(
      margin: EdgeInsets.all(10),
      child: Table(
        border: TableBorder.all(),
        columnWidths: {0: FractionColumnWidth(0.35)},
        children: body,
      ),
    );
  }

  List<TableRow> tableRowBuilder0(R10 r10) {
    List cell0 = [
      HealthPromotionServiceDescription.m0,
      HealthPromotionServiceDescription.m2,
      HealthPromotionServiceDescription.m3,
      HealthPromotionServiceDescription.m4,
      HealthPromotionServiceDescription.m5,
      HealthPromotionServiceDescription.m6,
      HealthPromotionServiceDescription.m7,
      HealthPromotionServiceDescription.m8,
      HealthPromotionServiceDescription.m9,
    ];
    List cell1 = [
      HealthPromotionServiceDescription.m1,
      r10.r1013,
      r10.r1019,
      r10.r1022,
      r10.r1027,
      r10.r1030,
      r10.r1034,
      r10.r1038,
      r10.r1042,
    ];
    if (cell0.length != cell1.length)
      throw Exception('cell0\'s size need to be the same as cell1');
    return List.generate(
      cell0.length,
      (index) => TableRow(children: [
        Container(
          constraints: BoxConstraints(minHeight: 70),
          color: index == 0 ? Colors.brown.shade200 : null,
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(cell0[index] ?? '-'),
          ),
        ),
        Container(
          constraints: BoxConstraints(minHeight: 70),
          color: index == 0 ? Colors.brown.shade200 : null,
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(cell1[index] ?? '-'),
          ),
        ),
      ]),
    );
  }

  ///---------------癌症篩檢結果資料---------------
  Widget table1(List list) {
    List<R11> r11 = list;
    List<TableRow> body = <TableRow>[];
    if (r11 != null && r11.isNotEmpty)
      r11.forEach((r11) {
        body.add(tableRowBuilder1(r11));
      });
    return Container(
      margin: EdgeInsets.all(10),
      child: Table(
        border: TableBorder.all(),
        children: body,
      ),
    );
  }

  TableRow tableRowBuilder1(R11 r11) {
    List<Widget> list = [];
    r11.r111array.forEach((r111array) {
      list.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CirclePoint(),
          Expanded(
            child: Text(HealthPromotionServiceDescription.p0(
              r111array.r1111,
              r111array.r1112,
              r111array.r1113,
            )),
          ),
        ],
      ));
    });
    return TableRow(children: [
      Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '${r11.r111}，${r11.r112}',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ]..addAll(list),
        ),
      )
    ]);
  }

  ///---------------過敏資料---------------
  Widget table2(List list) {
    List<R4> r4 = list;
    List<TableRow> body = <TableRow>[
      //the header of table
      TableRow(children: [
        padding(Text(HealthPromotionServiceDescription.m11)),
        padding(Text(HealthPromotionServiceDescription.m12)),
        padding(Text(HealthPromotionServiceDescription.m13)),
      ]),
    ];
    if (r4 != null && r4.isNotEmpty)
      r4.forEach((r4) {
        body.add(tableRowBuilder2(r4));
      });
    return customDecorator(
      Text(
        HealthPromotionServiceDescription.m10,
        textAlign: TextAlign.center,
      ),
      body,
    );
  }

  TableRow tableRowBuilder2(R4 r4) {
    return TableRow(children: [
      padding(Text(r4?.r41 ?? '-')),
      padding(Text(r4?.r45 ?? '-')),
      padding(Text(r4?.r42 ?? '-')),
    ]);
  }

  ///---------------器捐或安寧緩和醫療資料---------------
  Widget table3(List list) {
    List<R5> r5 = list;
    List<TableRow> body = <TableRow>[
      //the header of table
      TableRow(children: [
        padding(Text(HealthPromotionServiceDescription.m15)),
        padding(Text(HealthPromotionServiceDescription.m16)),
      ]),
    ];
    if (r5 != null && r5.isNotEmpty)
      r5.forEach((r5) {
        body.add(tableRowBuilder3(r5));
      });
    return customDecorator(
      Text(
        HealthPromotionServiceDescription.m14,
        textAlign: TextAlign.center,
      ),
      body,
    );
  }

  TableRow tableRowBuilder3(R5 r5) {
    return TableRow(children: [
      padding(Text(r5?.r51 ?? '-')),
      padding(Text(r5?.r53 ?? '-')),
    ]);
  }

  ///---------------預防接種資料---------------
  Widget table4(List list) {
    List<R6> r6 = list;
    List<TableRow> body = <TableRow>[
      //the header of table
      TableRow(children: [
        padding(Text(HealthPromotionServiceDescription.m18)),
        padding(Text(HealthPromotionServiceDescription.m19)),
        padding(Text(HealthPromotionServiceDescription.m20)),
      ]),
    ];
    if (r6 != null && r6.isNotEmpty)
      r6.forEach((r6) {
        body.add(tableRowBuilder4(r6));
      });
    return customDecorator(
      Text(
        HealthPromotionServiceDescription.m17,
        textAlign: TextAlign.center,
      ),
      body,
    );
  }

  TableRow tableRowBuilder4(R6 r6) {
    return TableRow(children: [
      padding(Text(r6?.r61 ?? '-')),
      padding(Text(r6?.r65 ?? '-')),
      padding(Text(r6?.r63 ?? '-')),
    ]);
  }

  ///---------------影像病理檢驗報告---------------
  Widget table5(List list) {
    List<R8> r8 = list;
    List<TableRow> body = <TableRow>[
      //the header of table
      TableRow(children: [
        padding(Text(HealthPromotionServiceDescription.m22)),
        padding(Text(HealthPromotionServiceDescription.m26)),
      ]),
    ];
    if (r8 != null && r8.isNotEmpty)
      r8.forEach((r8) {
        body.add(tableRowBuilder5(r8));
      });
    return customDecorator(
      Text(
        HealthPromotionServiceDescription.m21,
        textAlign: TextAlign.center,
      ),
      body,
    );
  }

  Widget customDecorator(Widget title, List<TableRow> body) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(),
                left: BorderSide(),
                right: BorderSide(),
              ),
            ),
            child: title,
          ),
          Table(
            border: TableBorder.all(),
            columnWidths: {0: FractionColumnWidth(0.33)},
            children: body,
          )
        ],
      ),
    );
  }

  TableRow tableRowBuilder5(R8 r8) {
    String title = '${r8?.r84 ?? ""}\n${r8?.r85 ?? ""}';
    String content = '${r8?.r88 ?? ""}${r8?.r89 ?? ""}\n${r8?.r810 ?? ""}';
    return TableRow(children: [
      padding(Text(title)),
      padding(Text(content)),
    ]);
  }
}
