import 'package:app/description/conclusionDescription.dart';
import 'package:app/description/dashbaordDescription.dart';
import 'package:app/model/boardItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/homeBloc.dart';
import '../../home/homeEvent.dart';
import '../util/appBarFactory.dart';

// ignore: must_be_immutable
class Conclusion extends StatelessWidget {
  List<Widget> list;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    list = itemBuilder(homeBloc);

    ///build
    return Scaffold(
      appBar: AppBarFactory.custom(
        context: context,
        title: DashBoardDescription.list[5].title,
        leadingImagePath: DashBoardDescription.list[5].imagePath,
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

  List<Widget> itemBuilder(HomeBloc homeBloc) {
    return ConclusionDescription.list.map((BoardItem boardItem) {
      return itemBlock(
        event: boardItem.event,
        homeBloc: homeBloc,
        imagePath: boardItem.imagePath,
        title: boardItem.title,
        content: boardItem.content,
      );
    }).toList();
  }

  Widget itemBlock({
    String imagePath,
    String title,
    String content,
    HomeBloc homeBloc,
    event,
  }) {
    return Container(
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () => homeBloc.add(event),
            child: Row(
              children: <Widget>[
                Image.asset(imagePath),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    title ?? '--',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            content ?? '--',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
