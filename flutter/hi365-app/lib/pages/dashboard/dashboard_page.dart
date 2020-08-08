import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/checkup/checkup_page.dart';
import 'package:hi365/pages/dashboard/dashboard_screen_new.dart';
import 'package:hi365/pages/dashboard/iconRotation.dart';
import 'package:hi365/pages/dashboard/index.dart';
import 'package:hi365/pages/healthbank/health_bank_root_screen.dart';
import 'package:hi365/pages/healthknowledge/health_knowledge_screen.dart';
import 'package:hi365/pages/home/home_bloc.dart';
import 'package:hi365/pages/iot/index.dart';
import 'package:hi365/pages/medical_examination/detail/report_detail.dart';
import 'package:hi365/pages/online_consulting/online_consulting_page.dart';
import 'package:hi365/pages/other_setting/other_setting.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_model.dart';
import 'package:hi365/utils/app_configs.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = "/dashboard";
  final Function iot;

  DashboardPage(this.iot);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ///Directory Of DashBoard.
  final List<Widget> _directory = [
    DashboardScreenNew(),//_index = 0
    IotPage(),//_index = 1
    CheckupPage(),//_index = 2
    HealthBankRootScreen(),//_index = 3
    HealthKnowledgeScreen(),//_index = 4
    OnlineConsultingPage(),//_index = 5
    DashboardScreenNew(),//_index = 6
    OtherSetting(),//_index = 7
  ];

  final GlobalKey<ScaffoldState> _dashboardKey = GlobalKey<ScaffoldState>();
  TextEditingController _meetingRoomTokenController = TextEditingController();
  static const _zoomChannel =
      const MethodChannel('com.h2uclub.hi365/join_meeting');
  int _index = 0;
  String statusMsg = '';
  bool isSync = true;
  bool displayStyle = true;

  RotationModel _rotationModel = RotationModel();

  PersonalModel _personalModel;

  DashboardProvider _dashboardProvider = DashboardProvider();

  @override
  void initState() {
    super.initState();
    syncIotData(_rotationModel);
    _personalModel = BlocProvider.of<HomeBloc>(context).personalModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _dashboardKey,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: AppConfig().primaryColor,
            size: 35,
          ),
          onPressed: () => _dashboardKey.currentState.openDrawer(),
        ),
        actions: generateAction(_index),
      ),
      drawer: displayStyle ? _drawerGrid() : _drawerList(),
      body: _index < _directory.length ? _directory[_index] : _directory[0],
    );
  }

  List<Widget> generateAction(num index) {
    List<Widget> toReturn = [];
    switch (index) {
      case 1:
        print(_rotationModel.running);
        toReturn.add(IconRotation(syncIotData, _rotationModel));
        break;
      default:
        break;
    }
    return toReturn;
  }

  syncIotData(RotationModel _rotationModel) async {
    if (_rotationModel == null) throw Exception('Input cannot be null');
    print("#####start IotSync");
    _rotationModel.running = true;
    await widget.iot();
    _rotationModel.running = false;
    print("#####end IotSync");
  }

  Future _showDialog(
    List<String> content,
  ) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            "錯誤訊息",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: Column(
                  children: content.map((value) {
                    return Text(
                      value ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, color: Colors.red),
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black.withOpacity(0.3)),
                          right:
                              BorderSide(color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                      child: GestureDetector(
                        child: new Text(
                          "確認",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff396C9B)),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  bool validation(String zoomId) {
    // RegExp zoomRegExp = RegExp("^[0-9]{9,10}\$", multiLine: true);
    bool toReturn = true;
    List<String> errorMsg = [];
    if (zoomId.length != 8) {
      errorMsg.add('錯誤會議ID。\n');
    }
    if (errorMsg.length > 0) {
      toReturn = false;
      _showDialog(errorMsg);
    }
    return toReturn;
  }

  Widget _drawerList() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _drawerHeader(),
          Expanded(
            child: ListView(
              children: _drawerBody(size: 30.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerGrid() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _drawerHeader(),
          Expanded(
            child: Container(
              child: GridView.count(
                padding: EdgeInsets.all(0),
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: _drawerBody(size: 40.0, grid: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerHeader() {
    return SafeArea(
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              leading: Image.asset(
                'assets/images/img_logo_hi365@2x.png',
                height: 30,
              ),
            ),
          ),
          IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(
              Icons.apps,
              size: 30,
            ),
            onPressed: () {
              displayStyle = !displayStyle;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _drawerBody({double size, bool grid: false}) {
    Color color = Theme.of(context).accentColor;
    return [
      Container(
        alignment: Alignment.center,
        decoration:
            boxDecoration(color: color, showBorder: grid, targetIndex: 0),
        child: ListTile(
          leading: grid
              ? null
              : Image.asset(
                  _index == 0
                      ? 'assets/images/ic_menu_dashboard_focus@2x.png'
                      : 'assets/images/ic_menu_dashboard@2x.png',
                  height: 30,
                ),
          title: AutoSizeText(
            reLine('首頁'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _index == 0 ? color : Colors.black,
              fontSize: size,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            _index = 0;
            setState(() {});
          },
        ),
      ),
      Container(
        alignment: Alignment.center,
        decoration:
            boxDecoration(color: color, showBorder: grid, targetIndex: 1),
        child: ListTile(
          leading: grid
              ? null
              : Image.asset(
                  _index == 1
                      ? 'assets/images/ic_menu_iot_focus@2x.png'
                      : 'assets/images/ic_menu_iot@2x.png',
                  height: 30,
                ),
          title: AutoSizeText(
            reLine('生理數據'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _index == 1 ? color : Colors.black,
              fontSize: size,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            _index = 1;
            setState(() {});
          },
        ),
      ),
      Container(
        alignment: Alignment.center,
        decoration:
            boxDecoration(color: color, showBorder: grid, targetIndex: 2),
        child: ListTile(
          leading: grid
              ? null
              : Image.asset(
                  _index == 2
                      ? 'assets/images/ic_menu_healthcheck_focus@2x.png'
                      : 'assets/images/ic_menu_healthcheck@2x.png',
                  height: 30,
                ),
          title: AutoSizeText(
            reLine('健檢資料'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _index == 2 ? color : Colors.black,
              fontSize: size,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            _index = 2;
            setState(() {});
          },
        ),
      ),
      Container(
        alignment: Alignment.center,
        decoration:
            boxDecoration(color: color, showBorder: grid, targetIndex: 3),
        child: ListTile(
          leading: grid
              ? null
              : Image.asset(
                  _index == 3
                      ? 'assets/images/ic_menu_healthbook_focus@2x.png'
                      : 'assets/images/ic_menu_healthbook@2x.png',
                  height: 30,
                ),
          title: AutoSizeText(
            reLine('健康存摺'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _index == 3 ? color : Colors.black,
              fontSize: size,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            _index = 3;
            setState(() {});
          },
        ),
      ),
      Container(
        alignment: Alignment.center,
        decoration:
            boxDecoration(color: color, showBorder: grid, targetIndex: 4),
        child: ListTile(
          leading: grid
              ? null
              : Image.asset(
                  _index == 4
                      ? 'assets/images/ic_menu_article_focus@2x.png'
                      : 'assets/images/ic_menu_article@2x.png',
                  height: 30,
                ),
          title: AutoSizeText(
            reLine('健康知識庫'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _index == 4 ? color : Colors.black,
              fontSize: size,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            _index = 4;
            setState(() {});
          },
        ),
      ),
      Container(
        alignment: Alignment.center,
        decoration:
            boxDecoration(color: color, showBorder: grid, targetIndex: 5),
        child: ListTile(
          leading: grid
              ? null
              : Image.asset(
                  _index == 7
                      ? 'assets/images/ic_menu_onlinechat_focus@2x.png'
                      : 'assets/images/ic_menu_onlinechat@2x.png',
                  height: 30,
                ),
          title: AutoSizeText(
            reLine('線上咨詢'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _index == 7 ? color : Colors.black,
              fontSize: size,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            _index = 5;
            setState(() {});
          },
        ),
      ),
      Container(
        alignment: Alignment.center,
        decoration:
            boxDecoration(color: color, showBorder: grid, targetIndex: 9),
        child: ListTile(
          leading: grid
              ? null
              : Image.asset(
                  _index == 9
                      ? 'assets/images/ic_menu_article_focus@2x.png'
                      : 'assets/images/ic_menu_article@2x.png',
                  height: 30,
                ),
          title: AutoSizeText(
            reLine('線上���約'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _index == 9 ? color : Colors.black,
              fontSize: size,
            ),
          ),
          onTap: () async {
            Navigator.of(context).pop();
            _index = 9;
            const url = 'http://61.218.61.46:83/';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
            setState(() {});
          },
        ),
      ),
      Container(
        alignment: Alignment.center,
        decoration:
            boxDecoration(color: color, showBorder: grid, targetIndex: 10),
        child: ListTile(
          leading: grid
              ? null
              : Image.asset(
                  _index == 10
                      ? 'assets/images/ic_menu_onlinechat_focus@2x.png'
                      : 'assets/images/ic_menu_onlinechat@2x.png',
                  height: 30,
                ),
          title: AutoSizeText(
            reLine('線上問卷'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _index == 10 ? color : Colors.black,
              fontSize: size,
            ),
          ),
          onTap: () async {
            Navigator.of(context).pop();
            _index = 10;
            const url = 'http://61.218.61.46:81/';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
            setState(() {});
          },
        ),
      ),
      Container(
        alignment: Alignment.center,
        decoration:
            boxDecoration(color: color, showBorder: grid, targetIndex: 8),
        child: ListTile(
          leading: grid
              ? null
              : Image.asset(
                  _index == 8
                      ? 'assets/images/ic_menu_logout_focus@2x.png'
                      : 'assets/images/ic_menu_logout@2x.png',
                  height: 30,
                ),
          title: AutoSizeText(
            reLine('其他與設定'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _index == 8 ? color : Colors.black,
              fontSize: size,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            _index = 8;
            setState(() {});
          },
        ),
      ),
    ];
  }

  String reLine(String text) {
    if (!displayStyle) return text;
    if (text.length <= 2) return text;
    int i = (text.length / 2).round();
    return text.replaceRange(i, i, '\n');
  }

  BoxDecoration boxDecoration(
      {Color color, bool showBorder: false, int targetIndex}) {
    return BoxDecoration(
      color: _index == targetIndex ? color.withOpacity(0.1) : Colors.white,
      border: showBorder ? Border.all(color: color) : null,
      borderRadius: BorderRadius.circular(10),
    );
  }
}
