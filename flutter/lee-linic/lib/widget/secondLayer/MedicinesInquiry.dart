import 'package:app/description/conclusionDescription.dart';
import 'package:app/description/medicinesInquiryDescription.dart';
import 'package:app/home/homeBloc.dart';
import 'package:app/home/homeEvent.dart';
import 'package:app/model/healthInfo.dart';
import 'package:app/widget/util/circlePoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';

import '../util/appBarFactory.dart';

class MedicinesInquiry extends StatefulWidget {
  @override
  MedicinesInquiries createState() => MedicinesInquiries();
}

class MedicinesInquiries extends State<MedicinesInquiry> {
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
    /// build
    return Scaffold(
      appBar: AppBarFactory.custom(
        context: context,
        title: ConclusionDescription.list[2].title,
        leadingImagePath: ConclusionDescription.list[2].imagePath,
        trailingImagePath: ConclusionDescription.homeIcon,
        trailingImageOnTap: () async {
          homeBloc.add(HomeEvent.conclusion);
        },
      ),
      body: Container(
        margin: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
//            searchBar(),
            Expanded(
              child: tabBarBuilder(),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(),
          ),
          Icon(Icons.search),
        ],
      ),
    );
  }

  Widget tabBarBuilder() {
//    print(homeBloc.drugInquiry.keys);
    return DefaultTabController(
      length: homeBloc.drugInquiry.keys.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade100,
          elevation: 0,
          title: TabBar(
            isScrollable: true,
            tabs: homeBloc.drugInquiry.keys.map((v) => Tab(text: v)).toList(),
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: homeBloc.drugInquiry.values
              .map((r1s) => tabBarViewBody(r1s))
              .toList(),
        ),
      ),
    );
  }

  Widget tabBarViewBody(List<R1> r1s) {
//    print(r1s);
    return SingleChildScrollView(
      child: Column(
        children: r1s.map((r1) => eachRecord(r1)).toList(),
      ),
    );
  }

  Widget eachRecord(R1 r1) {
    String date = r1.r15.trim().length == 0 ? r1.r16 : r1.r15;

    //add title.
    List<Widget> children = []
      ..add(
          Text(MedicinesInquiryDescription.medicinesDetailTitle(date, r1.r14)))
      ..add(Divider(thickness: 2.0, color: Colors.black))
      ..addAll(r1.r11array
          .map((r11array) => medicinesWithPoint(text: r11array.r112)))
      ..add(Divider(
        thickness: 0.0,
      ))
      ..add(Text(MedicinesInquiryDescription.m1))
      ..add(Divider())
      ..add((MedicinesDetail(r1.r11array, homeBloc.data)));

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      color: Color(0xFFBBDFED),
      constraints: BoxConstraints(
        minHeight: 200.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  Widget medicinesWithPoint({String text}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CirclePoint(),
          Expanded(
            child: Text(text ?? '-'),
          ),
        ],
      ),
    );
  }

  Widget drugDetail() {
    return Text('');
  }
}

class MedicinesDetail extends StatefulWidget {
  final List<R11array> r11array;
  dynamic data;

  MedicinesDetail(this.r11array, this.data);

  @override
  _MedicinesDetailState createState() => _MedicinesDetailState();
}

class _MedicinesDetailState extends State<MedicinesDetail> {
  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return hasData(widget.r11array)
        ? messageWithNullData()
        : isCollapsed
            ? expandedButton()
            : details(widget.r11array, widget.data);
  }

  bool hasData(List<R11array> r11array) {
    return r11array == null || r11array.length <= 0;
  }

  Widget messageWithNullData() {
    return Text(MedicinesInquiryDescription.m0);
  }

  Widget expandedButton() {
    return FlatButton(
      child: Icon(
        Icons.keyboard_arrow_down,
        size: 30,
        semanticLabel: 'Expanded the medicines detail',
      ),
      onPressed: () {
        isCollapsed = !isCollapsed;
        setState(() {});
      },
    );
  }

  Widget collapsedButton() {
    return FlatButton(
      child: Icon(
        Icons.keyboard_arrow_up,
        size: 30,
        semanticLabel: 'Collapse the medicines detail',
      ),
      onPressed: () {
        isCollapsed = !isCollapsed;
        setState(() {});
      },
    );
  }

  Widget details(List<R11array> r11array, dynamic data) {
    return HtmlWidget(
      data,
      onTapUrl: (_url) async => await launch(_url),
    );
    return Column(
        children: <Widget>[]
          ..addAll(r11array.map((r11array) => detailLayOut(r11array)))
          ..add(collapsedButton()));
  }

  Widget detailLayOut(R11array r11array) {
    List content = [r11array.r112, '-', '-', '-', '-'];
    List<Widget> result = MedicinesInquiryDescription.m2
        .asMap()
        .map((index, v) {
          return MapEntry(index, rowLayout(v, content[index]));
        })
        .values
        .toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: result..add(Divider()),
    );
  }

  Widget rowLayout(String title, String content) {
    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: Text(title ?? '-')),
        Expanded(flex: 2, child: Text(content ?? '-')),
      ],
    );
  }
}
