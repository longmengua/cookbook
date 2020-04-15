import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/checkup/checkup_event.dart';
import 'package:hi365/pages/checkup/checkup_model.dart';
import 'package:hi365/pages/checkup/checkup_no_data_screen.dart';
import 'package:hi365/pages/dashboard/dashboard_screen_new.dart';
import 'package:hi365/pages/home/home_bloc.dart';
import 'package:hi365/utils/snackbars.dart';
import 'package:intl/intl.dart';

import '../checkup_bloc.dart';
import 'bloc/bloc.dart';
import 'checkup_detail_pdf_screen.dart';
import 'checkup_detail_sub_screen.dart';

class CheckupDetailScreen extends StatefulWidget {
  const CheckupDetailScreen({
    Key key,
  }) : super(key: key);

  @override
  CheckupDetailScreenState createState() => CheckupDetailScreenState();
}

class CheckupDetailScreenState extends State<CheckupDetailScreen> {
  ///Those height properties below, set up with 0 will be collapse, set up with null will be expand.
  double adviceContentHeight = 0;
  double detailHeight = 0;
  double attachHeight = 0;
  Map<String, double> categoryHeightList = {};

  HomeBloc _homeBloc;

  @override
  void initState() {
    if (BlocProvider.of<CheckupDetailBloc>(context).state
        is InitializedCheckupDetail) {
      BlocProvider.of<CheckupDetailBloc>(context).add(CleanDeatail());
    }
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckupDetailBloc, CheckupDetailState>(
      listener: (context, currentState) {
        if (currentState is ErrorCheckupDetail) {
          BlocProvider.of<CheckupBloc>(context)
              .add(ErrorOccurEvent(currentState.errorMessage));
        } else if (currentState is LoadingCheckupDetail) {
          SnackBarBuilder.showLoading(context, '資料讀取中…');
        }
      },
      child: BlocBuilder<CheckupDetailBloc, CheckupDetailState>(
        builder: (context, currentState) {
          if (currentState is InitializedCheckupDetail) {
            return _shoeDetailContainer(currentState.data, currentState.advice);
          } else if (currentState is NoCheckupDetailData) {
            return CheckupNoDataScreen();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _shoeDetailContainer(
      List<CheckupDetail> data, CheckupMaster checkupMaster) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _showAdviceTitle(),
            _showAdvice(checkupMaster, adviceContentHeight),
            _showAttach(checkupMaster, adviceContentHeight),
            _showCheckupHeader(),
            _showDetailContent(data, detailHeight),
            Space,
          ],
        ),
      ),
    );
  }

  Widget _showAdviceTitle() {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
        child: Row(
          children: <Widget>[
            Container(
              height: 60,
              margin: EdgeInsets.only(right: 20),
              child: Image.asset(
                'assets/checkup/ic_table_docotor@2x.png',
                fit: BoxFit.fill,
              ),
            ),
            Text(
              '醫生總評',
              style: TextStyle(fontSize: 26),
            ),
            Spacer(),
            Transform.rotate(
              angle: adviceContentHeight == 0.0 ? 0.0 : 4.7,
              child: Icon(
                Icons.chevron_left,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          adviceContentHeight = adviceContentHeight == null ? 0.0 : null;
        });
      },
    );
  }

  Widget _showAdvice(CheckupMaster checkupMaster, num height) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      padding: EdgeInsets.all(15),
      height: height,
      child: Text(
        checkupMaster?.doctorAssessment ?? '',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _showCheckupHeader() {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
        child: Row(
          children: <Widget>[
            Container(
              height: 60,
              margin: EdgeInsets.only(right: 20),
              child: Image.asset(
                'assets/checkup/ic_table_healthcheck@2x.png',
                fit: BoxFit.fill,
              ),
            ),
            Text(
              '健檢項目',
              style: TextStyle(fontSize: 26),
            ),
            Spacer(),
            Transform.rotate(
              angle: detailHeight == 0.0 ? 0.0 : 4.7,
              child: Icon(
                Icons.chevron_left,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          detailHeight = detailHeight == null ? 0.0 : null;
        });
      },
    );
  }

  Widget _showDetailContent(List<CheckupDetail> data, num height) {
    List<Widget> toReturn = [];
    String categoryBuf;
    data..sort((a, b) => a.category.compareTo(b.category));
    bool isErr = false;
    int position;

    data.forEach((checkupDetail) {
      if (categoryBuf != checkupDetail.category) {
        if (position != null) {
          toReturn.insert(position, _category(isErr, categoryBuf));
          position = null;
          isErr = false;
        }
        position = toReturn.length;
        categoryHeightList.putIfAbsent(checkupDetail.category, () => 0);
        categoryBuf = checkupDetail.category;
      }
      toReturn.add(_content(checkupDetail, checkupDetail.category));
      isErr = isErr || checkupDetail.err == '1';
    });
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      height: height,
      child: Column(
        children: toReturn,
      ),
    );
  }

  Widget _category(bool isErr, String category) {
    return GestureDetector(
      child: Container(
        color: Color(0xFFFF6900).withOpacity(0.1),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                category.trim() == '' ? '-' : category,
                style: TextStyle(
                  fontSize: 20,
                  color: isErr ? Colors.red : Colors.black,
                ),
              ),
            ),
            Spacer(),
            Transform.rotate(
              angle: categoryHeightList[category] == 0.0 ? 0.0 : 4.7,
              child: Icon(
                Icons.chevron_left,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        categoryHeightList[category] =
            categoryHeightList[category] == null ? 0.0 : null;
        setState(() {});
      },
    );
  }

  Widget _content(CheckupDetail checkupDetail, String category) {
    String value = checkupDetail?.valueText ?? '';
    String ref = checkupDetail?.refText ?? '';
    bool hasImage = checkupDetail?.healthCheckReportAttachList != null &&
        checkupDetail.healthCheckReportAttachList.length >= 0;

    value = value.trim() == '' ? null : value;
    ref = ref.trim() == '' ? null : ref;

    return Container(
      height: categoryHeightList[category],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Color(0xFFFF6900).withOpacity(0.26),
            child: Text(
              checkupDetail?.checkItemName ?? '-',
              style: TextStyle(
                fontSize: 20,
                color: checkupDetail?.err == '1' ? Colors.red : Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '檢查結果',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Text(
                        value ?? '-',
                        style: TextStyle(
                          fontSize: 20,
                          color: checkupDetail?.err == '1'
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: hasImage
                      ? Text('')
                      : FlatButton(
                          child: Image.asset(
                            'assets/checkup/ic_table_image@2x.png',
                            height: 30,
                            width: 30,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CheckupDetailSubScreen(checkupDetail),
                              ),
                            );
                          },
                        ),
                )
              ],
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  '參考值',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  ref ?? '-',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget _showAttach(CheckupMaster checkupMaster, num height) {
    ///DateFormat is in 'package:intl/intl.dart'
    String dateString = DateFormat('yyyyMMdd')
        .format(DateTime.fromMillisecondsSinceEpoch(checkupMaster.checkDate));
    List<Widget> toReturn = [];
    checkupMaster.healthCheckReportAttachList.forEach((v) {
      toReturn.add(
        Container(
          height: 50,
          margin: EdgeInsets.all(10),
          child: OutlineButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.red)),
            textColor: Theme.of(context).accentColor,
            borderSide: BorderSide(
                color: Theme.of(context).accentColor.withOpacity(0.8)),
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.description),
                Text(
                  v?.description ?? '',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckupDetailPDFScreen(
                    v, dateString, _homeBloc?.personalModel?.govId),
              ),
            ),
          ),
        ),
      );
    });
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Divider(),
          Text(
            '附件',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 24),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: toReturn,
            ),
          ),
        ],
      ),
    );
  }
}
