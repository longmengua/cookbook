import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:hi365/pages/checkup/checkup_detail/bloc/bloc.dart';
import 'package:hi365/pages/checkup/index.dart';

import 'bloc/bloc.dart';
import 'bloc/checkup_master_bloc.dart';

class CheckupMasterScreen extends StatefulWidget {
  const CheckupMasterScreen({
    Key key,
  }) : super(key: key);

  @override
  CheckupMasterScreenState createState() => CheckupMasterScreenState();
}

class CheckupMasterScreenState extends State<CheckupMasterScreen> {
  CheckupMasterBloc _checkupMasterBloc;

  int _currentIndex = 0;
  double _multiplier = 1.0;

  ///The range of _multiplier is between 1.0 ~ 2.0, which means it does have 10 level on it.

  @override
  void initState() {
    super.initState();
    _checkupMasterBloc = BlocProvider.of<CheckupMasterBloc>(context);
    _checkupMasterBloc.add(LoadCheckupMaster());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckupMasterBloc, CheckupMasterState>(
      listener: (context, currentState) {
        if (currentState is ErrorCheckupMaster) {
          BlocProvider.of<CheckupBloc>(context)
              .add(ErrorOccurEvent(currentState.errorMessage));
        } else if (currentState is NoCheckupMasterData) {
          BlocProvider.of<CheckupBloc>(context).add(ShowNoDataPage());
        } else if (currentState is LoadingCheckupMaster) {
          BlocProvider.of<CheckupBloc>(context).add(ShowLoadingSnackBar());
        } else if (currentState is InitializedCheckupMaster) {
          BlocProvider.of<CheckupDetailBloc>(context)
              .add(LoadDetail(currentState.data[0].id, currentState.data[0]));
        }
      },
      child: BlocBuilder<CheckupMasterBloc, CheckupMasterState>(
        builder: (context, currentState) {
          if (currentState is InitializedCheckupMaster) {
//            return _showMaster(currentState.data);
            return _hospitalBoard(currentState.data);
          }
          return Container();
        },
      ),
    );
  }

  Widget _hospitalBoard(List<CheckupMaster> data) {
    return Column(
      children: <Widget>[
        _hospitalPageView(data),
        _dotScroller(data.length),
      ],
    );
  }

  Widget _dotScroller(num length) {
    double size = 12;
    return Wrap(
      children: List<Widget>.generate(
        length,
        (i) => Container(
          height: size,
          width: size,
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentIndex == i
                  ? Theme.of(context).accentColor
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _hospitalPageView(List<CheckupMaster> data) {
    return Container(
      height: 100,
      child: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          String date = DateFormat('yyyy-MM-dd').format(
                DateTime.fromMillisecondsSinceEpoch(data[index].checkDate),
              ) ??
              '';
          String name = data[index].hospitalName ?? '未知的院所';
          return Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
// 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 1.0),
                    blurRadius: 1.0,
                    spreadRadius: 1.0),
              ],
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'assets/checkup/ic_card_healthreport@2x.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: AutoSizeText(
                          '$name',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '$date 個人健檢報告',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        itemCount: data.length,
        onPageChanged: (index) {
          BlocProvider.of<CheckupDetailBloc>(context)
              .add(LoadDetail(data[index].id, data[index]));
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
