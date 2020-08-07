part of iot;

class IotPage extends StatefulWidget {
  @override
  _IotPage createState() {
    return _IotPage();
  }
}

class _IotPage extends State<IotPage> {
  Repository repository = Repository();
  Business business = Business();
  Future future;
  TextEditingController _textEditingController = TextEditingController();

  List menu = ['單日', '3日', '7日', '14日', '30日'];
  List duration = [1, 3, 7, 14, 30];
  List<Widget> weekDays = <Widget>[
    Transform.rotate(angle: 45.0, child: Text('週ㄧ')),
    Transform.rotate(angle: 45.0, child: Text('週二')),
    Transform.rotate(angle: 45.0, child: Text('週三')),
    Transform.rotate(angle: 45.0, child: Text('週四')),
    Transform.rotate(angle: 45.0, child: Text('週五')),
    Transform.rotate(angle: 45.0, child: Text('週六')),
    Transform.rotate(angle: 45.0, child: Text('週日')),
  ];
  final Map<int, Widget> childrenForGlucose = [1, 3, 7, 14, 30]
      .map((v) {
        return Text('${v.toString()}日');
      })
      .toList()
      .asMap();

  final Map<int, Widget> children = ['日', '週', '月', '年']
      .map((v) {
        return Text(v);
      })
      .toList()
      .asMap();

  int _index = 1;
  int _indexGlucose = 1;

  refresh([int i, num days]) {
    setState(() {
      future = repository.fitKitType == FitKitType.BLOOD_SUGAR
          ? initForGlucose(i, repository.glucoseDuration)
          : init(i);
    });
  }

  @override
  void initState() {
    future = init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return home(_size, chart(_size));
          } else if (snapshot.connectionState == ConnectionState.none) {
            return loading(_size);
          } else {
            return home(_size, circleLoading());
          }
        },
      ),
    );
  }

  ///Main page entry point.
  Widget home(Size size, Widget chartArea) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          children: <Widget>[
            repository.fitKitType == FitKitType.BLOOD_SUGAR
                ? segmentedControlGlucose(size, childrenForGlucose)
                : segmentedControl(size, children),
            dateText(size),
            chartArea,
            scrollbar(),
//            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  Widget add(BuildContext context, bool additionalButton) {
    if (additionalButton == null || !additionalButton) return Text('');
    Glucose glucose;
    FocusNode _focusNode;
    return SizedBox(
      height: 25,
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Glucose answer = await showDialog(
              context: context,
              builder: (
                BuildContext context,
              ) {
                Calendar calendar = Calendar();
                String hint = '請輸入血糖.';
                num showMeal = 0.0;
                bool loading = false;
                String _date;
                glucose = Glucose();
                glucose.unit = 'unit';
                _focusNode = FocusNode();
                _textEditingController.value = TextEditingValue(text: '');

                ///Using StatefulBuild to give dialog a state which can re-render after the content of the dialog has changed.
                return StatefulBuilder(
                  builder: (context, glucoseState) {
                    return AlertDialog(
                      title: Text('新增血糖'),
                      content: SingleChildScrollView(
                        child: SizedBox(
                          height: 300,
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 300,
                                      child: GestureDetector(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(0.4)),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                _date ?? '請輸入日期',
                                                style: TextStyle(
                                                    color: _date == null
                                                        ? Colors.black
                                                            .withOpacity(0.6)
                                                        : Theme.of(context)
                                                            .accentColor),
                                              ),
                                              IconButton(
                                                icon: Opacity(
                                                  opacity: 0.5,
                                                  child: Icon(
                                                      Icons.calendar_today),
                                                ),
                                                onPressed: () async {
                                                  await calendar
                                                      .dateTimePicker(context,
                                                          bool: true)
                                                      .then((date) {
                                                    _date = date
                                                        .toString()
                                                        .substring(0, 16);
                                                    glucose.startDate = date ==
                                                            null
                                                        ? null
                                                        : date
                                                            .millisecondsSinceEpoch;
                                                    glucose.endDate =
                                                        glucose.startDate;
                                                  });
                                                  if (mounted)
                                                    glucoseState(() {});
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 300,
                                      height: 50,
                                      child: TextField(
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor),
                                        focusNode: _focusNode
                                          ..addListener(() {
                                            if (_focusNode.hasFocus) {
                                              hint = '';
                                            }
                                          }),
                                        controller: _textEditingController,
                                        onChanged: (v) {
                                          try {
                                            int tmp = num.tryParse(v);
                                            glucose.value = tmp;
                                            glucoseState(() {});
                                          } catch (e) {
                                            //When an exception occurred, then rollback
                                            //Usually, it happened when meeting the invalid non-number char.
                                            _textEditingController?.value =
                                                TextEditingValue(
                                                    text: glucose?.value
                                                            ?.toString() ??
                                                        '');
                                          }
                                        },
                                        decoration: new InputDecoration(
                                            labelText: hint,
                                            suffixIcon: Icon(Icons.add)),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    Container(
                                        child: DropdownButtonFormField(
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(0)),
                                            isExpanded: true,
                                            onChanged: (value) {
                                              if ([
                                                '飯前',
                                                '飯後',
                                              ].contains(value)) {
                                                showMeal = 1.0;
                                              } else {
                                                showMeal = 0.0;
                                              }
                                              glucose.mealType = value;
                                              if (mounted) glucoseState(() {});
                                            },
                                            hint: Text(
                                              glucose.mealType ?? '量測時段.',
                                              style: TextStyle(
                                                  color:
                                                      glucose.mealType == null
                                                          ? Colors.black
                                                              .withOpacity(0.6)
                                                          : Theme.of(context)
                                                              .accentColor),
                                            ),
                                            items: [
                                              '起床',
                                              '睡前',
                                              '半夜',
                                              '運動前',
                                              '運動後',
                                              '飯前',
                                              '飯後',
                                              '其他',
                                            ].map((value) {
                                              return DropdownMenuItem(
                                                child: Text('${value ?? ''}'),
                                                value: value,
                                              );
                                            }).toList())),
                                    Opacity(
                                      opacity: showMeal,
                                      child: SizedBox(
                                          width: 300,
                                          child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(0)),
                                              isExpanded: true,
                                              onChanged: (value) {
                                                glucose.dining = value;
                                                if (mounted)
                                                  glucoseState(() {});
                                              },
                                              hint: Text(
                                                  glucose.dining ?? '餐別.',
                                                  style: TextStyle(
                                                      color: glucose.dining ==
                                                              null
                                                          ? Colors.black
                                                              .withOpacity(0.6)
                                                          : Theme.of(context)
                                                              .accentColor)),
                                              items: [
                                                '早餐',
                                                '午餐',
                                                '晚餐',
                                                '點心',
                                              ].map((value) {
                                                return DropdownMenuItem(
                                                  child: Text('$value'),
                                                  value: value,
                                                );
                                              }).toList())),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      actions: <Widget>[
                        OutlineButton(
                          child: const Text('取消'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        OutlineButton(
                          child: const Text('確認'),
                          onPressed: validation(glucose)
                              ? () async {
                                  loading = true;
                                  if (mounted) glucoseState(() {});
                                  await business
                                      .saveGlucoseToBackground(glucose);
                                  glucose.startDate = null;
                                  glucose.endDate = null;
                                  glucose.value = null;
                                  glucose.mealType = null;
                                  glucose.dining = null;
                                  refresh();
                                  Navigator.of(context).pop();
                                }
                              : null,
                        )
                      ],
                    );
                  },
                );
              });
        },
      ),
    );
  }

  Widget segmentedControl(Size size, Map<int, Widget> _children) {
    return Container(
      width: size.width,
      height: 40,
      child: CupertinoSegmentedControl<int>(
        children: _children,
        onValueChanged: (int index) {
          _index = index;
          repository.period = Period.values.elementAt(index);
          repository.typeOfData = business.mappingType(repository.period);
          refresh();
        },
        groupValue: _index,
      ),
    );
  }

  Widget segmentedControlGlucose(Size size, Map<int, Widget> _children) {
    return Container(
      width: size.width,
      height: 40,
      child: CupertinoSegmentedControl<int>(
        children: _children,
        onValueChanged: (int index) {
          _indexGlucose = index;
          repository.glucoseDuration = duration.elementAt(index);
          refresh();
        },
        groupValue: _indexGlucose,
      ),
    );
  }

  Widget singleDateOption(String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: OutlineButton(
        disabledBorderColor: Theme.of(context).primaryColor,
        textColor: Colors.purple,
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        splashColor: Colors.lightBlueAccent,
        child: Text(
          title,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget dateText(Size size) {
    return Container(
      height: 40,
      child: Row(
        children: <Widget>[
          Expanded(
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                refresh(2);
              },
            ),
          ),
          SizedBox(
              width: 200,
              child: FlatButton(
                onPressed: () async {
                  var date = await Calendar()
                      .dateTimePicker(context, dateTime: repository.startDate);
                  if (date == null) return;
                  repository.startDate = date;
                  refresh();
                },
                child: Text(
                  '${repository.startDate.toString().substring(0, 10)} ~ ${repository.endDate.toString().substring(0, 10)}',
                  textAlign: TextAlign.center,
                ),
              )),
          Expanded(
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                refresh(1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget chart(Size size) {
    num padding = 0.0;
    final children = <Widget>[];
    if (repository.detailOnChartPoint.dateTime != null) {
      int end = 4;
      List values = repository.detailOnChartPoint.values;
      if (repository.fitKitType == FitKitType.BLOOD_SUGAR) {
        end = repository.glucoseDuration == 1 ? 16 : 10;
      } else {
        switch (repository.period) {
          case Period.Day:
            end = 16;
            break;
          case Period.Week:
            end = 10;
            break;
          case Period.Month:
            end = 10;
            break;
          case Period.Year:
            end = 7;
            break;
        }
      }
      children.add(Text(
          '${repository.detailOnChartPoint.dateTime?.toString()?.substring(0, end)}'));
      children.add(horizontalDivider());
      if (repository.fitKitType == FitKitType.SLEEP) {
        children.add(Text('${values?.first?.toStringAsFixed(0)} ％'));
        if (values.length > 1 && values?.elementAt(1) != null)
          children
              .add(Text(' (${values?.elementAt(1)?.toStringAsFixed(0)} 分)'));
      } else if (values.length == 1) {
        if (repository.fitKitType == FitKitType.ACTIVITY) {
          children.add(Text('${values?.first?.toStringAsFixed(0)} 步'));
        } else if (repository.fitKitType == FitKitType.WEIGHT) {
          children.add(Text('${values?.first?.toStringAsFixed(0)} KG'));
        } else if (repository.fitKitType == FitKitType.BLOOD_SUGAR) {
          children.add(Text('${values?.first?.toStringAsFixed(0)} mg/dl'));
        }
      } else if (values.length == 2) {
        children.add(Text('最小值\n${values[0].toString()}'));
        children.add(horizontalDivider(width: 0.0));
        children.add(Text('最大值\n${values[1].toString()}'));
      }
      repository.detailOnChartPoint.dateTime = null;
      padding = 5.0;
    }
    return Column(children: <Widget>[
      SizedBox(
        height: 50,
        child: Row(
          children: [
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: EdgeInsets.all(padding),
                color: Colors.deepOrangeAccent.withOpacity(0.6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: children,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      drawChart(
          selection: onSelectionChanged,
          data: repository.responseBody,
          period: repository.period,
          duration: repository.glucoseDuration,
          fitKitType: repository.fitKitType,
          ticks: repository.ticks),
      SizedBox(
        height: 1,
        width: MediaQuery.of(context).size.width,
        child: (repository.fitKitType != FitKitType.BLOOD_SUGAR &&
                repository.period == Period.Week)
            ? createSticks(repository.startDate.weekday - 1)
            : null,
      ),
    ]);
  }

  Widget scrollbar() {
    return SizedBox(
      height: 140,
      child: PageView.builder(
        onPageChanged: (index) async {
          repository.fitKitType = FitKitType.values.elementAt(index);
          refresh();
        },
        itemCount: ItemBuilder.length,
        controller: PageController(viewportFraction: 0.7, initialPage: 0),
        itemBuilder: (buildContext, index) {
          return create(ItemBuilder.healthInfo[index], repository.topLowest);
        },
      ),
    );
  }

  Widget create(Item healthInfo, List topLowest) {
    ItemBuilder itemBuilder = ItemBuilder();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: healthInfo.color,
          child: OutlineButton(
            onPressed: () => null,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(children: <Widget>[
                Row(
                  ///Note: The line code of below is same as putting the Spacer() between Widgets.
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    itemBuilder._title(healthInfo.title),
                    Spacer(),
                    add(context, healthInfo.additionalButton),
                  ],
                ),
                Spacer(),
                itemBuilder._content(
                    type: repository.fitKitType,
                    period: repository.period,
                    detailUnit: healthInfo.detailUnit,
                    detailTitle: healthInfo.detailTitle,
                    detailContent: topLowest),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  transferResponse(FitKitType fitKitType, List response, Period period) async {
    List toReturn = [];
    switch (fitKitType) {
      case FitKitType.HEART_RATE:
        num max, min;
        response?.forEach((value) {
          if (max == null || value['maxValue'] > max) max = value['maxValue'];
          if (min == null || value['minValue'] < min) min = value['minValue'];
        });
        toReturn..add(max?.toStringAsFixed(0))..add(min?.toStringAsFixed(0));
        break;
      case FitKitType.BLOOD_PRESSURE:
        num max, min;
        response?.forEach((value) {
          if (max == null || value['systolic'] > max) max = value['systolic'];
          if (min == null || value['diastolic'] < min) min = value['diastolic'];
        });
        toReturn..add(max?.toStringAsFixed(0))..add(min?.toStringAsFixed(0));
        break;
      case FitKitType.SLEEP:
        num max, min;
        min = 0;
        max = 0;
        if (response.length != 0) {
          response.forEach((value) {
//            min += value['inbedEndTime'] - value['inbedStartTime'];
            min += value['sleepTotalTime'] ?? 0;
            max += value['quality'] ?? 0;
            //print(DateTime.fromMillisecondsSinceEpoch(value['sleepDate']));
            //print(value['iotDeviceId']);
          });
//          min = Duration(milliseconds: min).inMinutes;
          max ~/= (response.length);
          min ~/= response.length;
        }
        toReturn..add(max.toStringAsFixed(0))..add(min.toStringAsFixed(0));
        break;
      case FitKitType.ACTIVITY:
        num max, min;
        max = 0;
        min = 0;
        response.forEach((value) {
          max += value['count'] ?? 0;
        });
        if (period != Period.Day && response.length != 0)
          max ~/= response.length;
        min = max * 0.024;
        toReturn..add(max.toStringAsFixed(0))..add(min.toStringAsFixed(0));
        break;
      case FitKitType.WEIGHT:
        num max, min;
        final response = await business.getWeightDetail(
          repository.startDate.millisecondsSinceEpoch,
          repository.endDate.millisecondsSinceEpoch,
        );
        List list = response?.data['data'];
        if (list.length == 0) break;
        max = list.elementAt(0)['weight'] ?? 0;
        min = list.elementAt(0)['bmi'] ?? 0;
        toReturn..add(max.toStringAsFixed(2));
        break;
      case FitKitType.BLOOD_SUGAR:
        num max, min;
        final response = await business.getGlucoseAverageDetail(
          repository.startDate.millisecondsSinceEpoch,
          repository.endDate.millisecondsSinceEpoch,
        );
        List list = response?.data['data'];
        if (list.length == 0) break;
        max = list.elementAt(0)['maxValue'];
        min = list.elementAt(0)['minValue'];
        toReturn..add(max.toStringAsFixed(0))..add(min.toStringAsFixed(0));
        break;
      default:
        break;
    }
    return toReturn;
  }

  init([num option]) async {
    final dateInfo =
        calculator(repository.period, repository.startDate, option: option);
    repository.startDate = dateInfo['startDate'];
    repository.endDate = dateInfo['endDate'];
    final ticksInfo = generateStaticTicks(
        period: repository.period, dateTime: dateInfo['startDate']);
    repository.ticks = ticksInfo['ticks'];
    final response = await business.getDataWithType(
        repository.startDate.millisecondsSinceEpoch,
        repository.endDate.millisecondsSinceEpoch,
        repository.typeOfData,
        repository.fitKitType);
    repository.responseBody =
        response.data['data'].length == 0 ? [] : response.data['data'];
    repository.topLowest = await transferResponse(
        repository.fitKitType, repository.responseBody, repository.period);
    return true; //DateTime.fromMillisecondsSinceEpoch(repository.responseBody[7]['date'])
  }

  initForGlucose([num option, num days]) async {
    final dateInfo = calculatorForGlucose(
        repository.startDate, Duration(days: days),
        option: option);
    repository.startDate = dateInfo['startDate'];
    repository.endDate = dateInfo['endDate'];
    repository.ticks = generateStaticTicksForGlucose(
        days: repository.glucoseDuration, dateTime: repository.startDate);
    final response = await business.getDataWithGlucose(
      repository.startDate.millisecondsSinceEpoch,
      repository.endDate.millisecondsSinceEpoch,
    );
    repository.responseBody =
        response.data['data'].length == 0 ? [] : response.data['data'];
    repository.topLowest = await transferResponse(
        repository.fitKitType, repository.responseBody, repository.period);
    return true;
  }

  // Listens to the underlying selection changes, and updates the information
  // relevant to building the primitive legend like information under the
  // chart.
  void onSelectionChanged(SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    repository.detailOnChartPoint.values = [];
    repository.detailOnChartPoint.dateTime = null;
    try {
      if (selectedDatum.isNotEmpty) {
        if (repository.fitKitType == FitKitType.ACTIVITY) {
          repository.detailOnChartPoint.dateTime =
              DateTime.fromMillisecondsSinceEpoch(
                  selectedDatum.first.datum['recordDateTime']);
          repository.detailOnChartPoint.values
              .add(selectedDatum[0].datum['count']);
        } else if (repository.fitKitType == FitKitType.SLEEP) {
          repository.detailOnChartPoint.dateTime =
              DateTime.fromMillisecondsSinceEpoch(
                  selectedDatum.first.datum['sleepDate']);
          repository.detailOnChartPoint.values
              .add(selectedDatum[0].datum['quality']);
          repository.detailOnChartPoint.values
              .add(selectedDatum[0].datum['sleepTotalTime']);
        } else if (repository.fitKitType == FitKitType.WEIGHT) {
          repository.detailOnChartPoint.dateTime =
              DateTime.fromMillisecondsSinceEpoch(
                  selectedDatum.first.datum['startDate']);
          repository.detailOnChartPoint.values
              .add(selectedDatum[0].datum['value']);
        } else if (repository.fitKitType == FitKitType.BLOOD_SUGAR) {
          repository.detailOnChartPoint.dateTime =
              DateTime.fromMillisecondsSinceEpoch(
                  selectedDatum.first.datum['startDate']);
          repository.detailOnChartPoint.values
              .add(selectedDatum[0].datum['value']);
        } else {
          repository.detailOnChartPoint.dateTime =
              selectedDatum.first.datum['date'];
          bool buf =
              selectedDatum[0].datum['value'] > selectedDatum[1].datum['value'];
          repository.detailOnChartPoint.values
              .add(selectedDatum[buf ? 1 : 0].datum['value']);
          repository.detailOnChartPoint.values
              .add(selectedDatum[buf ? 0 : 1].datum['value']);
        }
        repository.detailOnChartPoint.show = true;
      } else {
        repository.detailOnChartPoint.show = false;
      }
    } catch (e) {
      print(e);
    }
    if (mounted) setState(() {});
  }

  Widget createSticks(int startedWeekDay) {
    List<Widget> toReturn = [];
    toReturn.addAll(weekDays);
    toReturn.addAll(weekDays);

    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: Container(
            color: Color(0xffF9F9F9),
            height: 30,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: toReturn.sublist(startedWeekDay, startedWeekDay + 7),
            ),
          ),
        )
      ],
    );
  }
}
