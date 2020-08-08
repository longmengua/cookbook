part of '../index.dart';

Widget drawChart({
  List data,
  Period period,
  FitKitType fitKitType, //this parameter is for different type.
  List ticks,
  num duration,
  Function selection,
}) {
  List<Series<dynamic, DateTime>> _data =
      dateSeriesGeneration(data, fitKitType);
  Widget toReturn;
  String quality = '-';
  String sleepTotalTime = '-';
  String wakeTime = '-';
  String inBedMinutes = '-';
  if (fitKitType == FitKitType.SLEEP && period == Period.Day) {
    if (data.length > 0) {
      quality = data.first['quality']?.toString() ?? '-';
      sleepTotalTime = data.first['sleepTotalTime']?.toString() ?? '-';
      wakeTime = data.first['wakeTime']?.toString() ?? '-';
      inBedMinutes = Duration(
                  milliseconds: data?.first['inbedEndTime'] -
                      data?.first['inbedStartTime'])
              .inMinutes
              .toString() ??
          '-';
    }
    toReturn = dayOfSleep(
        quality: quality,
        sleepMinutes: sleepTotalTime,
        inBedMinutes: inBedMinutes,
        wakeUpMinutes: wakeTime);
  } else {
    toReturn = Container(
      margin: EdgeInsets.only(top: 0),
      height: 300,
      child: TimeSeriesChart(
        _data ?? [],
        selectionModels: [
          new SelectionModelConfig(
            type: SelectionModelType.info,
            changedListener: selection,
          )
        ],
        behaviors: fitKitType == FitKitType.BLOOD_SUGAR
            ? [
                SeriesLegend(),
              ]

            ///todo:if no data with this RangeAnnotation would cause an error 'hasSize'.
//            : fitKitType == FitKitType.HEART_RATE
//                ? [
//                    RangeAnnotation([
//                      RangeAnnotationSegment(
//                          50, 150, RangeAnnotationAxisType.measure,
//                          startLabel: '最低',
//                          endLabel: '最高',
//                          labelAnchor: AnnotationLabelAnchor.end,
//                          color: chart.Color.fromHex(code: '#B0E0E6'))
//                    ]),
//                  ]
            : [],

        ///labels on the top of the chart area which represents each the name of the line.
        defaultRenderer: formatChartData(fitKitType),
        primaryMeasureAxis: NumericAxisSpec(
          renderSpec: GridlineRendererSpec(
              labelOffsetFromAxisPx: 10,
              labelOffsetFromTickPx: 20,
              labelRotation: 0,
              lineStyle: LineStyleSpec(
                dashPattern: [5, 5],
              )),
          showAxisLine: true,
          tickProviderSpec: BasicNumericTickProviderSpec(
              dataIsInWholeNumbers: true,
              desiredTickCount: 11,
              desiredMaxTickCount: fitKitType == FitKitType.SLEEP ? 1 : 100),
        ),
        domainAxis: DateTimeAxisSpec(
          renderSpec: GridlineRendererSpec(
              labelOffsetFromTickPx: 0,
              labelOffsetFromAxisPx: 10,
              labelRotation: 50,
              lineStyle: LineStyleSpec(
                dashPattern: [5, 5],
              )),
          showAxisLine: true,
          tickProviderSpec: StaticDateTimeTickProviderSpec(ticks),
          tickFormatterSpec: fitKitType == FitKitType.BLOOD_SUGAR
              ? formatTimeTicksForGlucose(duration)
              : formatTimeTicks(period),
        ),
      ),
    );
  }
  return toReturn;
}

///The style of rendering in chart, like line, bar, point, and so on.
SeriesRendererConfig formatChartData(FitKitType fitKitType) {
  SeriesRendererConfig toReturn;
  switch (fitKitType) {
    case FitKitType.SLEEP:
      toReturn = BarRendererConfig<DateTime>(
        cornerStrategy: const ConstCornerStrategy(10),
//        stackHorizontalSeparator: 30,
//        strokeWidthPx: 1,
      );
      break;
    case FitKitType.ACTIVITY:
    case FitKitType.WEIGHT:
      toReturn = BarRendererConfig<DateTime>(
        cornerStrategy: const ConstCornerStrategy(10),
      );
      break;
    case FitKitType.HEART_RATE:
      toReturn = LineRendererConfig<DateTime>(
        includeArea: true,
        roundEndCaps: true,
        includeLine: true,
//        includePoints: true,
//        radiusPx: 10,
      );
      break;
    case FitKitType.BLOOD_PRESSURE:

    case FitKitType.BLOOD_SUGAR:
      toReturn = LineRendererConfig<DateTime>(
        roundEndCaps: true,
        strokeWidthPx: 5,
        includeLine: true,
//        includePoints: true,
//        radiusPx: 10,
      );
      break;
  }
  return toReturn;
}

///generate static time ticks
Map generateStaticTicks({Period period, DateTime dateTime}) {
  Map toReturn = Map();
  DateTime dateFrom = dateTime;
  List<TickSpec<DateTime>> ticks = [];

  switch (period) {
    case Period.Day:
      for (int i = 0; i <= 24; i += 3) {
        ticks.add(
            TickSpec(DateTime(dateFrom.year, dateFrom.month, dateFrom.day, i)));
      }
      break;
    case Period.Week:
      dateFrom = DateTime(
        dateFrom.year,
        dateFrom.month,
        dateFrom.day,
      ).subtract(Duration(days: dateFrom.weekday - DateTime.monday));
      for (int i = 0; i < 7; i++) {
        ticks.add(TickSpec(
            DateTime(dateFrom.year, dateFrom.month, dateFrom.day + i)));
      }
      break;
    case Period.Month:
      int duration = DateTime(dateFrom.year, dateFrom.month + 1)
          .subtract(Duration(days: 1))
          .day;
      ticks.add(TickSpec(DateTime(dateFrom.year, dateFrom.month, 1)));
      for (int i = 1; i < duration ~/ 3; i++) {
        ticks.add(TickSpec(DateTime(dateFrom.year, dateFrom.month, i * 3 + 1)));
      }
      ticks.add(TickSpec(DateTime(dateFrom.year, dateFrom.month, duration)));
      break;
    case Period.Year:
      for (int i = 1; i <= 12; i++) {
        ticks.add(TickSpec(DateTime(dateFrom.year, i)));
      }
      break;
    default:
      break;
  }
  toReturn.putIfAbsent('ticks', () => ticks);
  toReturn.putIfAbsent('length', () => ticks.length);
  return toReturn;
}

///generate static time ticks for glucose
List<TickSpec<DateTime>> generateStaticTicksForGlucose(
    {num days, DateTime dateTime}) {
  List<TickSpec<DateTime>> toReturn = [];
  num addend;
  num counter;

  switch (days) {
    case 1:
      addend = 3;
      counter = 24;
      break;
    case 3:
      addend = 1;
      counter = days;
      break;
    case 7:
      addend = 2;
      counter = days;
      break;
    case 14:
      addend = 1;
      counter = days;
      break;
    case 30:
      addend = 5;
      counter = days;
      break;
  }

  if (days == 1) {
    for (int i = 0; i < counter; i += addend) {
      toReturn.add(TickSpec(
          DateTime(dateTime.year, dateTime.month, dateTime.day, i, 0, 0)));
    }
    toReturn.add(TickSpec(
        DateTime(dateTime.year, dateTime.month, dateTime.day + 1, 0, 0, 0)));
  } else {
    for (int i = 0; i < counter; i += addend) {
      toReturn.add(TickSpec(
          DateTime(dateTime.year, dateTime.month, dateTime.day + i, 0, 0, 0)));
    }
    toReturn.add(TickSpec(DateTime(
        dateTime.year, dateTime.month, dateTime.day + days - 1, 0, 0, 0)));
  }

  return toReturn;
}

///Format time ticks.
DateTimeTickFormatterSpec formatTimeTicksForGlucose(num duration) {
  return AutoDateTimeTickFormatterSpec(
    hour: duration > 1
        ? TimeFormatterSpec(
            format: 'MM/dd',
            transitionFormat: 'MM/dd',
          )
        : TimeFormatterSpec(
            format: 'HH:00',
            transitionFormat: 'HH:00\nMM/dd',
            noonFormat: 'HH:00'),
//    day: TimeFormatterSpec(
//      format: 'MM/dd',
//      transitionFormat: 'MM/dd',
//    ),
  );
}

///Format time ticks.
DateTimeTickFormatterSpec formatTimeTicks(Period period) {
  TimeFormatterSpec format = period == Period.Day
      ? TimeFormatterSpec(
          format: 'HH:00',
          transitionFormat: 'HH:00\nMM/dd',
          noonFormat: 'HH:00')
      : TimeFormatterSpec(
          format: 'MM/dd',
          transitionFormat: 'MM/dd',
        );
  return AutoDateTimeTickFormatterSpec(
    minute: TimeFormatterSpec(
      format: '',
      transitionFormat: '',
      noonFormat: '',
    ),
    hour: format,
    day: TimeFormatterSpec(
      format: 'MM/dd',
      transitionFormat: 'MM/dd',
    ),
    month: TimeFormatterSpec(
      format: 'MM',
      transitionFormat: 'MM\nyyyy',
      noonFormat: 'MM\nyyyy',
    ),
    year: TimeFormatterSpec(
      format: 'MM',
      transitionFormat: 'MM\nyyyy',
      noonFormat: 'MM\nyyyy',
    ),
  );
}

///When press arrow, reset the date period of text.
///option: 1 -> plus, 2-> minus.
Map calculator(Period period, DateTime dateTime, {num option}) {
  Map toReturn = Map();
  DateTime now = dateTime;
  DateTime dateFrom;
  DateTime dateTo;

  switch (period) {
    case Period.Day:
      if (option == 1) now = now.add(Duration(days: 1));
      if (option == 2) now = now.subtract(Duration(days: 1));
      dateFrom = DateTime(now.year, now.month, now.day, 0, 0, 0);
      dateTo =
          dateFrom.add(Duration(days: 1)).subtract(Duration(microseconds: 1));
      break;
    case Period.Week:
      if (option == 1) now = now.add(Duration(days: 7));
      if (option == 2) now = now.subtract(Duration(days: 7));
      dateFrom = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: now.weekday - DateTime.monday));
      dateTo =
          dateFrom.add(Duration(days: 7)).subtract(Duration(microseconds: 1));
      break;
    case Period.Month:
      if (option == 1) now = DateTime(now.year, now.month + 1);
      if (option == 2) now = DateTime(now.year, now.month - 1);
      dateFrom = DateTime(now.year, now.month);
      dateTo =
          DateTime(now.year, now.month + 1).subtract(Duration(microseconds: 1));
      break;
    case Period.Year:
      if (option == 1) now = DateTime(now.year + 1);
      if (option == 2) now = DateTime(now.year - 1);
      dateFrom = new DateTime(now.year);
      dateTo = DateTime(now.year + 1).subtract(Duration(microseconds: 1));
      break;
    default:
      break;
  }
  toReturn.putIfAbsent('startDate', () => dateFrom);
  toReturn.putIfAbsent('endDate', () => dateTo);
  return toReturn;
}

///When press arrow, reset the date period of text.
///option: 1 -> plus, 2-> minus.
Map calculatorForGlucose(DateTime now, Duration duration, {num option}) {
  Map toReturn = Map();
  DateTime dateFrom = DateTime(now.year, now.month, now.day, 0, 0, 0);
  DateTime dateTo;

  if (option == 1) now = now.add(duration);
  if (option == 2) now = now.subtract(duration);
  dateFrom = DateTime(now.year, now.month, now.day, 0, 0, 0);
  dateTo = dateFrom.add(duration).subtract(Duration(microseconds: 1));

  toReturn.putIfAbsent('startDate', () => dateFrom);
  toReturn.putIfAbsent('endDate', () => dateTo);
  return toReturn;
}

List<Series<dynamic, DateTime>> dateSeriesGeneration(
    List data, FitKitType fitKitType) {
  List<Series<dynamic, DateTime>> toReturn = [];

  switch (fitKitType) {
    case FitKitType.ACTIVITY:
      toReturn.add(Series<dynamic, DateTime>(
        id: 'activity',
        colorFn: (_, _index) => MaterialPalette.blue.shadeDefault,
        domainFn: (item, __) {
          return DateTime.fromMillisecondsSinceEpoch(item['recordDateTime']);
        },
        measureFn: (item, _) {
          return item['count'] ?? 0;
        },
        data: data,
      ));
      break;
    case FitKitType.WEIGHT:
      toReturn.add(Series<dynamic, DateTime>(
        id: 'weight',
        colorFn: (_, _index) => MaterialPalette.blue.shadeDefault,
        domainFn: (item, __) {
          return DateTime.fromMillisecondsSinceEpoch(item['startDate']);
        },
        measureFn: (item, _) {
          return item['value'] ?? 0;
        },
        data: data,
      ));
      break;
    case FitKitType.BLOOD_SUGAR:
      Map colors = {
        '起床': MaterialPalette.blue.shadeDefault,
        '睡前': MaterialPalette.cyan.shadeDefault,
        '半夜': MaterialPalette.deepOrange.shadeDefault,
        '運動前': MaterialPalette.indigo.shadeDefault,
        '運動後': MaterialPalette.pink.shadeDefault,
        '飯前': MaterialPalette.green.shadeDefault,
        '飯後': MaterialPalette.red.shadeDefault,
        '其他': MaterialPalette.yellow.shadeDefault,
      };
      Map<String, List> map = Map();
      data.forEach((value) {
        String key = value['mealType'];
        if (!map.containsKey(key)) {
          map.putIfAbsent(key, () => []);
        }
        map[key].add(value);
      });
      map.forEach((key, value) {
        toReturn.add(Series<dynamic, DateTime>(
          id: key.toString(),
          colorFn: (_, _index) {
            return colors[key];
          },
          domainFn: (item, __) {
            DateTime dateTime =
                DateTime.fromMillisecondsSinceEpoch(item['startDate']);
//            print('>>> $dateTime');
            return DateTime(
                dateTime.year, dateTime.month, dateTime.day, dateTime.hour);
          },
          measureFn: (item, _) {
            return item['value'] ?? 0;
          },
          data: value,
        ));
      });
      break;
    case FitKitType.HEART_RATE:
      List max = [];
      List min = [];
      data.forEach((v) {
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(v['date']);
        min.add({'date': dateTime, 'value': v['minValue']});
        max.add({'date': dateTime, 'value': v['maxValue']});
      });
      data.asMap().forEach((index, item) {
        toReturn.add(Series<dynamic, DateTime>(
          id: '最低心率',
          colorFn: (_, __) => chart.Color.fromHex(code: '#32CD32'),
          domainFn: (one, __) {
            return (one['date']);
          },
          measureFn: (one, _) {
            return one['value'];
          },
          data: min,
        ));
        toReturn.add(Series<dynamic, DateTime>(
          id: '最高心率',
          colorFn: (_, __) => chart.Color.fromHex(code: '#1E90FF'),
          domainFn: (one, __) {
            return (one['date']);
          },
          measureFn: (one, _) {
            return one['value'];
          },
          data: max,
        ));
      });
      break;
    case FitKitType.BLOOD_PRESSURE:
      data.asMap().forEach((index, item) {
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(item['date']);
        toReturn.add(Series<dynamic, DateTime>(
          id: index.toString(),
          colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
          domainFn: (one, __) {
            return one['date'];
          },
          measureFn: (one, _) {
            return one['value'];
          },
          data: [
            {'date': dateTime, 'value': item['diastolic']},
            {'date': dateTime, 'value': item['systolic']}
          ],
        ));
      });
      break;
    case FitKitType.SLEEP:
      toReturn.add(Series<dynamic, DateTime>(
        id: 'sleep',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (item, __) {
          DateTime toReturn =
              DateTime.fromMillisecondsSinceEpoch(item['sleepDate']);
          return toReturn;
        },
        measureFn: (item, _) {
          return item['quality'] ?? 0;
        },
        data: data,
      ));
      break;
  }
  return toReturn;
}

///todo: change this to a form.
bool validation(Glucose glucose) {
  bool toReturn = true;
  if (glucose.value == null ||
      glucose.startDate == null ||
      glucose.endDate == null ||
      glucose.mealType == null ||
      (glucose.mealType.contains('飯') && glucose.dining == null))
    toReturn = false;
  return toReturn;
}

Widget dayOfSleep({
  String quality,
  String sleepMinutes,
  String inBedMinutes,
  String wakeUpMinutes,
}) {
  return Container(
    height: 300,
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  height: 10,
                  child: FloatingActionButton(
                    backgroundColor: Colors.grey,
                    onPressed: () {},
                  )),
              Text('清醒時間', style: TextStyle(fontSize: 12)),
              Container(
                  height: 10,
                  child: FloatingActionButton(
                    backgroundColor: Colors.purple,
                    onPressed: () {},
                  )),
              Text('睡眠時間', style: TextStyle(fontSize: 12)),
              Container(
                  height: 10,
                  child: FloatingActionButton(
                    backgroundColor: Colors.cyan,
                    onPressed: () {},
                  )),
              Text('床上時間', style: TextStyle(fontSize: 12)),
            ],
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(left: 30, top: 10),
            child: SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      AutoSizeText(
                        '睡眠品質',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '$quality％',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '睡眠時間',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '$sleepMinutes分',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '床上時間',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '$inBedMinutes分',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '清醒時間',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '$wakeUpMinutes分',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Column(),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget circleLoading([num height]) {
  return SizedBox(
      height: height ?? 350, child: Center(child: CircularProgressIndicator()));
}

Widget customDivider() {
  return Row(children: <Widget>[
    Expanded(
      child: new Container(
          margin: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: Divider(
            color: Colors.black,
            height: 36,
          )),
    ),
    Text("OR"),
    Expanded(
      child: new Container(
          margin: const EdgeInsets.only(left: 20.0, right: 10.0),
          child: Divider(
            color: Colors.black,
            height: 36,
          )),
    ),
  ]);
}

Widget horizontalDivider({num height, num width, Color color}) {
  return (Container(
    color: color ?? Colors.black,
    height: height ?? 30,
    width: width ?? 1,
    margin: EdgeInsets.symmetric(horizontal: 10),
  ));
}

Widget cupertinoDateTimePicker(
    {@required BuildContext buildContext,
    DateTime dateTime,
    Function onDateTimeChanged}) {
  return CupertinoDatePicker(
    mode: CupertinoDatePickerMode.dateAndTime,
    initialDateTime: dateTime,
    onDateTimeChanged: onDateTimeChanged,
  );
}
