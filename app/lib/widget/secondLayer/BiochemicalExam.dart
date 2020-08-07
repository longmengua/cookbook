import 'dart:io';

import 'package:app/config/appConfig.dart';
import 'package:app/config/requestURLInfo.dart';
import 'package:app/description/biochemicalDescription.dart';
import 'package:app/description/conclusionDescription.dart';
import 'package:app/home/homeBloc.dart';
import 'package:app/home/homeEvent.dart';
import 'package:app/model/chart.dart';
import 'package:app/model/healthInfo.dart';
import 'package:app/widget/util/aesCbcPkcs5Padding.dart';
import 'package:app/widget/util/dialogs.dart';
import 'package:app/widget/util/dioFactory.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../util/appBarFactory.dart';

class BiochemicalExam extends StatefulWidget {
  @override
  BiochemicalExams createState() => BiochemicalExams();
}

class BiochemicalExams extends State<BiochemicalExam> {
  final List<double> stops = <double>[0.0, 0.5, 1];

  final List<Color> color = <Color>[
    Colors.blue.shade100,
    Colors.blue.shade200,
    Colors.blue.shade400,
  ];

  final List<Color> color1 = <Color>[
    Colors.deepOrange.shade100,
    Colors.deepOrange.shade200,
    Colors.deepOrange.shade100,
  ];

  List<DataColumn> dataColumn;
  HomeBloc homeBloc;
  String selectedR7String;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    dataColumn = BiochemicalDescription.tableHeader
        .map((v) => DataColumn(label: Text(v)))
        .toList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFactory.custom(
        context: context,
        title: ConclusionDescription.list[1].title,
        leadingImagePath: ConclusionDescription.list[1].imagePath,
        trailingImagePath: ConclusionDescription.homeIcon,
        trailingImageOnTap: () async {
          homeBloc.add(HomeEvent.conclusion);
        },
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.yellow,
              child: buildDropDownList(homeBloc.examMap),
            ),
            Container(
              child: tableBuilder(),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
//                child: chart(),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  buildDropDownList(Map<String, List<R7>> examMap) {
    List<DropdownMenuItem<String>> items;
    if (examMap != null)
      items = examMap.keys.map((String key) {
        return DropdownMenuItem(
          value: key,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Text(key),
          ),
        );
      }).toList();
    return DropdownButton<String>(
      disabledHint: Text(BiochemicalDescription.nonData),
      isExpanded: true,
      isDense: true,
      focusColor: Colors.yellow,
      value: selectedR7String,
      icon: Icon(
        Icons.expand_more,
      ),
      iconSize: 40,
      onChanged: (String newR7) async {
        selectedR7String = newR7;
        await popover();
        setState(() {});
      },
      items: items,
    );
  }

  Widget tableBuilder() {
    if (selectedR7String == null) return null;
    List<DataRow> dataRows = []
      ..addAll(homeBloc.examMap[selectedR7String].map((v) {
        return DataRow(cells: <DataCell>[
          DataCell(Text(v.r74 ?? '')), //醫療機構
          DataCell(Text(v.r710 ?? '')), //檢驗名稱
          DataCell(Text(v.r76 ?? '')), //檢驗日期
          DataCell(Text(v.r711 ?? '')), //結果值
        ]);
      }));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        horizontalMargin: 10,
        columnSpacing: 10.0,
        columns: dataColumn,
        rows: dataRows,
      ),
    );
  }

  //繪製上下限
  Domain domain() {
    if (selectedR7String == null) return null;
    //The selectedR7String will be like 三酸甘油脂 || 09004C, so do have to split it to extract the key.
    String key = selectedR7String.split('||')[1].trim();
    List<Domain> result;
    List<Domain> domains = [
      Domain("09005C", minYaxis: 10, maxYaxis: 400, start: 70, end: 100),
      Domain("09006C", minYaxis: 2, maxYaxis: 20, start: 3.1, end: 6.4),
      Domain("09043C", minYaxis: 10, maxYaxis: 200, start: -1, end: 40),
      Domain("09044C", minYaxis: 10, maxYaxis: 200, start: -1, end: 130),
      Domain("09004C", minYaxis: 10, maxYaxis: 500, start: 30, end: 150),
      Domain("09001C", minYaxis: 50, maxYaxis: 400, start: 130, end: 200),
    ];
    result = domains.where((v) => v.key == key).toList();
    return result.length == 1 ? result[0] : null;
  }

//  Widget chart() {
//    if (selectedR7String == null) return null;
//    List<ChartData> chartData = [];
//    chartData
//      ..addAll(homeBloc.examMap[selectedR7String]
//          .map((v) => ChartData(num.tryParse(v.r76), num.tryParse(v.r711)))
//          .where((v) => v.value != null)
//          .toList());
//    Domain domains = domain(); //繪製上下限
////    print(domains);
//    return SfCartesianChart(
//      primaryYAxis: NumericAxis(
//        minimum: domains?.minYaxis,
//        maximum: domains?.maxYaxis,
//        plotBands: <PlotBand>[
//          PlotBand(
//            end: domains?.end ?? 0,
//            start: domains?.start ?? 0,
//            isVisible: true,
//            shouldRenderAboveSeries: true,
//            text: '參考值 ${domains?.start} ~ ${domains?.end}',
//            gradient: LinearGradient(
//              colors: color1,
//              stops: stops,
//              begin: Alignment.bottomCenter,
//              end: Alignment.topCenter,
//            ),
//          )
//        ],
//      ),
//      series: <ChartSeries>[
//        AreaSeries<ChartData, num>(
//          dataSource: chartData,
//          xValueMapper: (ChartData c, _) => c.date,
//          yValueMapper: (ChartData c, _) => c.value,
//          //This is for setting the color of the point.
//          pointColorMapper: (__, _) => Colors.black,
//          //This is for setting the color of the line.
//          borderColor: Colors.blue,
//          borderWidth: 2,
//          //This is for setting the color of the region.
////          color: Color(0xFFB3E5FC),
//          //This is for setting the color of the region with gradient.
//          gradient: LinearGradient(colors: color, stops: stops),
//          //This is for setting the opacity of the region.
//          opacity: 0.3,
//          markerSettings: MarkerSettings(
//              isVisible: true,
//              //This is for setting the filling color of the point.
//              color: Colors.red),
//          dataLabelSettings: DataLabelSettings(
//            textStyle: ChartTextStyle(color: Colors.red),
//            //This is for setting the color of the text.
//            opacity: 0,
//            isVisible: true,
//            alignment: ChartAlignment.far,
//          ),
//        ),
//      ],
//    );
//  }

  void popover() async {
    try {
      if (selectedR7String == null) return null;
      final result = await homeBloc.biochemicalExamPredicate(selectedR7String);
      if (result != null &&
          result?.data != null &&
          !result.toString().contains('.')) {
        print(selectedR7String);
        await Dialogs.alertMSG(
          context: context,
          title: BiochemicalDescription.m0,
          content: BiochemicalDescription.p0(
            homeBloc.examMap[selectedR7String]?.first?.r79,
            result?.toString(),
          ),
          close: BiochemicalDescription.m1,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
