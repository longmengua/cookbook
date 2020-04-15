import 'package:app/description/dashbaordDescription.dart';
import 'package:app/home/homeBloc.dart';
import 'package:app/home/homeEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/appBarFactory.dart';

class Diabetes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    ///build
    return Scaffold(
      appBar: AppBarFactory.custom(
        context: context,
        title: DashBoardDescription.list[0].title,
        leadingImagePath: DashBoardDescription.list[0].imagePath,
        trailingImagePath: DashBoardDescription.homeIcon,
        trailingImageOnTap: () async {
          homeBloc.add(HomeEvent.dashboard);
        },
      ),
      body: SingleChildScrollView(
        child: HtmlWidget(
          homeBloc.data,
          onTapUrl: (_url) async => await launch(_url),
        ),
      ),
    );
  }
}
