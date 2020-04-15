import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///This DateTimePicker will display like =>  '< 今天，2019-09-25 >'
///
/// @param _dateTime
///   default is DateTime.now() with only year, month, day.
///
/// @param _separator
///   is placed among numbers of the date string.
///   If separator = '/' => '< 今天，2019-09-25 >' turns to '< 今天，2019/09/25 >'
///
/// @param _isAD
///   default is represented as '2019/09/25'
///   If it turns to true, will be like '09/25/2019'
///
/// @param _callBack
///   callBack function will be trigger when right-arrow or left-arrow was tapped.
///   The implementation will be like (date){...}.
///
/// @param _duration
///   the number when date is calculating in day, month, year, hour.
///   default value is 1.
///
/// @param _period
///   choose the gap of date-time, it can be year, month, day, hour.
///   default value is day.
// ignore: must_be_immutable
class DateTimePicker extends StatefulWidget {
  DateTime _dateTime;
  num _arrowSize;
  num _fontSize;
  String _separator;
  Function(DateTime) _callBack;
  bool _isAD;
  int _duration;
  String _period;

  DateTimePicker(
      {DateTime dateTime,
      double arrowSize,
      double fontSize,
      String separator,
      bool isAD,
      @required Function(DateTime) callBack,
      int duration,
      String period})
      : assert(callBack != null) {
    _dateTime = dateTime == null
        ? DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)
        : DateTime(dateTime.year, dateTime.month, dateTime.day);
    _arrowSize = arrowSize ?? 25.0;
    _fontSize = fontSize ?? 14.0;
    _separator = separator ?? '/';
    _isAD = isAD ?? false;
    _callBack = callBack ?? () {};
    _duration = duration ?? 1;
    _period = period ?? 'day';
  }

  @override
  _State createState() {
    return _State(
      _dateTime,
      _arrowSize,
      _separator,
      _isAD,
      _callBack,
      _duration,
      _period,
      _fontSize,
    );
  }
}

class _State extends State<DateTimePicker> {
  final List<String> weekDays = [
    '週一',
    '週二',
    '週三',
    '週四',
    '週五',
    '週六',
    '週日',
  ];
  final Map<String, Function(DateTime, int)> periodDirectory = {
    'year': (DateTime dateTime, int num) {
      return DateTime(
        dateTime.year + num,
        dateTime.month,
        dateTime.day,
      );
    },
    'month': (DateTime dateTime, int num) {
      return DateTime(
        dateTime.year,
        dateTime.month + num,
        dateTime.day,
      );
    },
    'day': (DateTime dateTime, int num) {
      return DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day + num,
      );
    },
  };
  DateTime _dateTime;
  String _separator;
  bool _isAD;
  num _arrowSize;
  num _fontSize;
  Function(DateTime) _callBack;
  int _duration;
  String _period;

  _State(DateTime dateTime, num arrowSize, String separator, bool isAD,
      Function(DateTime) callBack, int duration, String period, num fontSize)
      : _dateTime = dateTime,
        _separator = separator,
        _arrowSize = arrowSize,
        _isAD = isAD,
        _callBack = callBack,
        _period = period,
        _duration = duration,
        _fontSize = fontSize;

  DateTime get minusDay {
    return periodDirectory[_period](_dateTime, -_duration);
  }

  DateTime get plusDay {
    return periodDirectory[_period](_dateTime, _duration);
  }

  String get dateTimeString {
    String toReturn = _dateTime.toString().substring(0, 10);
    return toReturn.replaceAll('-', _separator);
  }

  String get weekDay {
    String toReturn = '，';
    DateTime now = DateTime.now();

    ///non-current month, year.
    if (!(_dateTime.year == now.year && _dateTime.month == now.month)) {
      toReturn = weekDays[_dateTime.weekday - 1] + toReturn;
      return toReturn;
    }
    switch (_dateTime.day - now.day) {
      case 0:
        toReturn = '今天' + toReturn;
        break;
      case -1:
        toReturn = '昨天' + toReturn;
        break;
      case 1:
        toReturn = '明天' + toReturn;
        break;
      default:
        toReturn = weekDays[_dateTime.weekday - 1] + toReturn;
    }
    return toReturn;
  }

  ///The reassemble method is executed only when hot-reload was triggered.
  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: _arrowSize,
          ),
          onPressed: () {
            _dateTime = minusDay;
            _callBack(_dateTime);
            setState(() {});
          },
        ),
        Text(
          '$weekDay$dateTimeString',
          style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(
            Icons.chevron_right,
            size: _arrowSize,
          ),
          onPressed: () {
            _dateTime = plusDay;
            _callBack(_dateTime);
            setState(() {});
          },
        ),
      ],
    );
  }
}
