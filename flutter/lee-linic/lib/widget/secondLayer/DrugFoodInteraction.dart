import 'package:app/config/requestURLInfo.dart';
import 'package:app/description/conclusionDescription.dart';
import 'package:app/description/drugFoodInteractionDescription.dart';
import 'package:app/home/homeBloc.dart';
import 'package:app/home/homeEvent.dart';
import 'package:app/model/healthInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/appBarFactory.dart';

class DrugFoodInteraction extends StatefulWidget {
  @override
  DrugFoodInteractions createState() => DrugFoodInteractions();
}

class DrugFoodInteractions extends State<DrugFoodInteraction> {
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
    Size size = MediaQuery.of(context).size;

    ///build
    return Scaffold(
      appBar: AppBarFactory.custom(
        context: context,
        title: ConclusionDescription.list[3].title,
        leadingImagePath: ConclusionDescription.list[3].imagePath,
        trailingImagePath: ConclusionDescription.homeIcon,
        trailingImageOnTap: () async {
          homeBloc.add(HomeEvent.conclusion);
        },
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              info(),
              hasMedicinesRecord(homeBloc.drugFoodInteraction),
              Divider(
                thickness: 2.0,
                height: 30,
              ),
              homeBloc.data == null
                  ? SizedBox()
                  : HtmlWidget(
                      homeBloc.data,
                      onTapUrl: (_url) async => await launch(_url),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget info() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(),
          color: Color(0xFFE0E0E0),
        ),
        padding: EdgeInsets.all(10),
        child: Text(DrugFoodInteractionDescription.mes0(
            DateTime.now().toString().substring(0, 10))));
  }

  Widget hasMedicinesRecord(Set<R11array> drugFoodInteraction) {
    return drugFoodInteraction.length > 0
        ? dataTable(drugFoodInteraction)
        : noDrugRecordInPeriod();
  }

  Widget noDrugRecordInPeriod() {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(),
            left: BorderSide(),
            bottom: BorderSide(),
          ),
          color: Color(0xFFD7CCC8),
        ),
        padding: EdgeInsets.all(10),
        child: Text(DrugFoodInteractionDescription.m0));
  }

  Widget dataTable(Set<R11array> drugFoodInteraction) {
    List<Widget> headers =
        [DrugFoodInteractionDescription.m1, DrugFoodInteractionDescription.m2]
            .map((v) => Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                constraints: BoxConstraints(minHeight: 60),
                color: Color(0xFFBCAAA4),
                child: Center(
                  child: Text(v),
                )))
            .toList();
    List<TableRow> tableRows = []
      ..add(TableRow(children: headers))
      ..addAll(drugFoodInteraction
          .map((r11array) => dataRowBuilder(r11array))
          .toList());
    return Table(
      columnWidths: {0: FractionColumnWidth(0.25)},
      border: TableBorder.all(),
      children: tableRows,
    );
  }

  TableRow dataRowBuilder(R11array r11array) {
    Duration duration = Duration(days: num.tryParse(r11array.r114) ?? 0);
    String dateString =
        '${r11array.startedDay?.toString()?.substring(0, 10) ?? "-"} ~ '
        '${r11array.startedDay.add(duration)?.toString()?.substring(0, 10) ?? "-"}';
    return TableRow(children: <Widget>[
      Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(r11array.r111 ?? '-'),
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(dateString),
            Text(r11array.r112 ?? '-'),
          ],
        ),
      ),
    ]);
  }
}
