import 'package:app/description/conclusionDescription.dart';
import 'package:app/description/medicalRecordDescription.dart';
import 'package:app/home/homeBloc.dart';
import 'package:app/home/homeEvent.dart';
import 'package:app/model/healthInfo.dart';
import 'package:app/widget/util/ExpandBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../util/appBarFactory.dart';

class MedicalRecord extends StatefulWidget {
  @override
  MedicalRecords createState() => MedicalRecords();
}

class MedicalRecords extends State<MedicalRecord> {
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
        title: ConclusionDescription.list[5].title,
        leadingImagePath: ConclusionDescription.list[5].imagePath,
        trailingImagePath: ConclusionDescription.homeIcon,
        trailingImageOnTap: () async {
          homeBloc.add(HomeEvent.conclusion);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            expandBoxWrapper(
              homeBloc.bdata.r2,
              table0,
              MedicalRecordDescription.group0,
            ),
            SizedBox(height: 10),
            expandBoxWrapper(
              homeBloc.bdata.r1,
              table1,
              MedicalRecordDescription.group1,
            ),
            SizedBox(height: 10),
            expandBoxWrapper(
              homeBloc.bdata.r9,
              table2,
              MedicalRecordDescription.group2,
            ),
            SizedBox(height: 10),
            expandBoxWrapper(
              homeBloc.bdata.r3,
              table3,
              MedicalRecordDescription.group3,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  //padding in common
  Widget padding(Widget addPadding) => Container(
        padding: EdgeInsets.all(10),
        child: addPadding,
      );

  Widget expandBoxWrapper(
    List list,
    Widget Function(List list) table,
    String header,
  ) {
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

  ///---------------住院---------------
  Widget table0(List list) {
    List<R2> r2 = list;
    List<TableRow> body = <TableRow>[
      //the header of table
      TableRow(children: [
        padding(Text(MedicalRecordDescription.m0)),
        padding(Text(MedicalRecordDescription.m1)),
        padding(Text(MedicalRecordDescription.m2)),
      ]),
    ];
    if (r2 != null && r2.isNotEmpty) {
      r2.sort((a, b) {
        int i = b.r24.compareTo(a.r24);
        return i != 0 ? i : b.r25.compareTo(a.r25);
      });
      r2.forEach((r2) {
        body.add(tableRowBuilder0(r2));
      });
    }
    return padding(Table(
      border: TableBorder.all(),
      children: body,
    ));
  }

  TableRow tableRowBuilder0(R2 r2) {
    return TableRow(children: [
      padding(Text(r2.r24 ?? '-')),
      padding(Text(r2.r25 ?? '-')),
      padding(Text(r2.r211 ?? '-')),
    ]);
  }

  ///---------------西醫門診紀錄---------------

  Widget table1(List list) {
    List<R1> r1 = list;
    List<TableRow> body = <TableRow>[
      //the header of table
      TableRow(children: [
        padding(Text(MedicalRecordDescription.m0)),
        padding(Text(MedicalRecordDescription.m1)),
        padding(Text(MedicalRecordDescription.m2)),
      ]),
    ];
    if (r1 != null && r1.isNotEmpty) {
      r1.sort((a, b) {
        int i = b.r14.compareTo(a.r14);
        return i != 0 ? i : b.r15.compareTo(a.r15);
      });
      r1.forEach((r1) {
        body.add(tableRowBuilder1(r1));
      });
    }
    return padding(Table(
      border: TableBorder.all(),
      children: body,
    ));
  }

  TableRow tableRowBuilder1(R1 r1) {
    return TableRow(children: [
      padding(Text(r1.r14 ?? '-')),
      padding(Text(r1.r15 ?? '-')),
      padding(Text(r1.r19 ?? '-')),
    ]);
  }

  ///---------------中醫門診紀錄---------------
  Widget table2(List list) {
    List<R9> r9 = list;
    List<TableRow> body = <TableRow>[
      //the header of table
      TableRow(children: [
        padding(Text(MedicalRecordDescription.m0)),
        padding(Text(MedicalRecordDescription.m1)),
        padding(Text(MedicalRecordDescription.m2)),
      ]),
    ];
    if (r9 != null && r9.isNotEmpty) {
      r9.sort((a, b) {
        int i = b.r94.compareTo(a.r94);
        return i != 0 ? i : b.r95.compareTo(a.r95);
      });
      r9.forEach((r9) {
        body.add(tableRowBuilder2(r9));
      });
    }
    return padding(Table(
      border: TableBorder.all(),
      children: body,
    ));
  }

  TableRow tableRowBuilder2(R9 r9) {
    return TableRow(children: [
      padding(Text(r9.r94 ?? '-')),
      padding(Text(r9.r95 ?? '-')),
      padding(Text(r9.r98 ?? '-')),
    ]);
  }

  ///---------------牙醫門診紀錄---------------
  Widget table3(List list) {
    List<R3> r3 = list;
    List<TableRow> body = <TableRow>[
      //the header of table
      TableRow(children: [
        padding(Text(MedicalRecordDescription.m0)),
        padding(Text(MedicalRecordDescription.m1)),
        padding(Text(MedicalRecordDescription.m2)),
      ]),
    ];
    if (r3 != null && r3.isNotEmpty) {
      r3.sort((a, b) {
        int i = b.r34.compareTo(a.r34);
        return i != 0 ? i : b.r35.compareTo(a.r35);
      });
      r3.forEach((r3) {
        body.add(tableRowBuilder3(r3));
      });
    }
    return padding(Table(
      border: TableBorder.all(),
      children: body,
    ));
  }

  TableRow tableRowBuilder3(R3 r3) {
    return TableRow(children: [
      padding(Text(r3.r34 ?? '-')),
      padding(Text(r3.r35 ?? '-')),
      padding(Text(r3.r38 ?? '-')),
    ]);
  }
}
