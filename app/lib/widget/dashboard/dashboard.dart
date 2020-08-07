import 'dart:io';

import 'package:app/description/dashbaordDescription.dart';
import 'package:app/home/homeBloc.dart';
import 'package:app/model/boardItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/appConfig.dart';
import '../util/appBarFactory.dart';
import '../util/dialogs.dart';

class DashBoard extends StatefulWidget {
  @override
  DashBoards createState() => DashBoards();
}

class DashBoards extends State<DashBoard> {
  HomeBloc homeBloc;
  List<Widget> list;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    list = itemBuilder(homeBloc);

    ///this is for checking policy had signed up.
    ///@see https://stackoverflow.com/questions/54610221/flutter-how-to-show-dialog-before-beginning-of-the-app
    if (homeBloc.userJson == null || homeBloc.userJson['policy'] == null)
      WidgetsBinding.instance.addPostFrameCallback((_) => policyDialog());
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
        title: DashBoardDescription.appName,
        leadingImagePath: DashBoardDescription.logoIcon,
        trailingImagePath: DashBoardDescription.policyIcon,
        trailingImageOnTap: () async {
          policyDialog();
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
    return DashBoardDescription.list.map((BoardItem boardItem) {
      return itemBlock(
        event: boardItem.event,
        homeBloc: homeBloc,
        imagePath: boardItem.imagePath,
        title: boardItem.title,
        content: boardItem.content,
      );
    }).toList()
      //This button is for testing.
      ..add(homeBloc.mode != 2
          ? SizedBox()
          : ListTile(
              trailing: Icon(Icons.add),
              title: Text('設定伺服器網址'),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Enter URL which can get healthbank json.'),
                    content: TextFormField(
                        initialValue: homeBloc.url,
                        onChanged: (text) =>
                            homeBloc.settingMockServerURL(text)),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('confirm',
                            style: TextStyle(color: Colors.black)),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                );
              },
            ))
      ..add(bottomSheet());
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
                    style: TextStyle(fontSize: 28),
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
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      child: FittedBox(
        fit: BoxFit.fill,
        child: Column(
          children: <Widget>[
            Text(
              DashBoardDescription.bottomSheet,
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              DashBoardDescription.mes0(AppConfig.version),
              style: TextStyle(fontSize: 24, color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }

  policyDialog() async {
    final result = await Dialogs.showCustomDialog(
      context: context,
      title: DashBoardDescription.policy.title,
      content: DashBoardDescription.policy.content,
      options: DashBoardDescription.options,
    );
    if (result != true) exit(0);
    homeBloc.policy();
  }
}
