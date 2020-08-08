import 'package:app/description/dashbaordDescription.dart';
import 'package:app/model/medicalItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home/homeBloc.dart';
import '../../home/homeEvent.dart';
import '../util/appBarFactory.dart';
import '../util/dialogs.dart';

class Medical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    List<Widget> list = itemBuilder(homeBloc, context);

    ///build
    return Scaffold(
      appBar: AppBarFactory.custom(
        context: context,
        title: DashBoardDescription.list[1].title,
        leadingImagePath: DashBoardDescription.list[1].imagePath,
        trailingImagePath: DashBoardDescription.homeIcon,
        trailingImageOnTap: () async {
          homeBloc.add(HomeEvent.dashboard);
        },
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) => list[index],
            separatorBuilder: (BuildContext context, int index) =>
                Divider(thickness: 2, height: 20),
            itemCount: list.length),
      ),
    );
  }

  List<Widget> itemBuilder(HomeBloc homeBloc, BuildContext context) {
    List<MedicalInfo> data = homeBloc.data;
    return data.map((MedicalInfo medicalInfo) {
      return itemBlock(
        title: medicalInfo.title,
        doctor: medicalInfo.doc,
        date: medicalInfo.date,
        url: medicalInfo.detail,
        homeBloc: homeBloc,
        context: context,
      );
    }).toList();
  }

  Widget itemBlock({
    HomeBloc homeBloc,
    String title,
    String doctor,
    String date,
    String url,
    BuildContext context,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            child: Text(
              title ?? '--',
              style: TextStyle(fontSize: 28),
            ),
            onTap: () async {
              final result = await homeBloc.dio.get(url);
//              print(result);
              Dialogs.showAlert(
                context: context,
                content: HtmlWidget(
                  result.data,
                  onTapUrl: (_url) async => await launch(_url),
                ),
              );
            },
          ),
          Row(
            children: <Widget>[
              Text(
                doctor ?? '--',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              Spacer(),
              Text(
                date ?? '--',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
