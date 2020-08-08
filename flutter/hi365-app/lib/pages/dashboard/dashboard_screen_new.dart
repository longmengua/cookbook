import 'dart:async';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hi365/pages/dashboard/index.dart';
import 'package:hi365/pages/dashboard/key_report/key_report.dart';
import 'package:hi365/pages/dashboard/key_report/key_report_dto.dart';
import 'package:hi365/pages/iot/ChartUtil/date_time.dart';
import 'package:hi365/pages/iot/index.dart';

const Space = SizedBox(
  height: 20,
);

class DashboardScreenNew extends StatefulWidget {
  final Dio dio = Dio();
  final DashboardRepository dashboardRepository = DashboardRepository();
  final Business business = Business();
  final int defaultIndex = 1;//setting up the default city according to airPollution list.
  final Map<String, List<AirPollution>> airPollution = {
    '基隆市': null,
    '新北市': null,
    '臺北市': null,
    '桃園市': null,
    '新竹市': null,
    '臺中市': null,
    '臺南市': null,
    '嘉義市': null,
    '高雄市': null,
    '宜蘭縣': null,
    '花蓮縣': null,
    '臺東縣': null,
    '新竹縣': null,
    '苗栗縣': null,
    '南投縣': null,
    '雲林縣': null,
    '彰化縣': null,
    '嘉義縣': null,
    '屏東縣': null,
    '澎湖縣': null,
    '金門縣': null,
    '連江縣': null, //媽祖
  };
  final keyReportMappingName = {
    'ACS': '冠心症',
    'BloodSyndrome': '血液',
    'BoneDisease': '骨質疏鬆症',
    'CAIDE': '失智症',
    'Gallstone': '膽',
    'KidneyFailure': '慢性腎臟病',
    'LiverCancer': '肝癌',
    'LiverDisease': '脂肪肝',
    'RespiratorySystem': '睡眠呼吸中止症',
    'StomachDisease': '胃',
    'allergy': '過敏',
    'metabolicSyndrome': '代謝症候群',
    'stroke': '腦中風',
  };
  final Map imagePaths = {
    'info': 'assets/keyreport/ic_info@2x.png',
    'warn': 'assets/keyreport/ic_warn@2x.png',
    'fatal': 'assets/keyreport/ic_fatal@2x.png',
    'error': 'assets/keyreport/ic_error@2x.png',
  };
  final Map<String, String> weatherImagePath = {
    '晴': 'assets/weather/sunny.png',
    '多雲': 'assets/weather/partlyCloudy.png',
    '陰': 'assets/weather/cloudy.png',
    '短暫雨': 'assets/weather/shower.png',
  };

  @override
  _State createState() => _State();
}

class _State extends State<DashboardScreenNew> {
  LunarCalenderAdvices _advices;
  DateTime _dateTime;
  String _heartRate;
  String _sleep;
  Map<String, KeyReportDTO> _reports;
  List<Location> _weatherData = [];
  Location weather;

  @override
  void initState() {
    weatherInformation().then((done)=>callBack());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        color: Color(0xffFAFAF5),
        child: Column(
          children: <Widget>[
            humanBody(size),
            Space,
            weatherBoard(),
            Space,
            DateTimePicker(callBack: callBack),
            Space,
            healthInfo(
              size,
              _heartRate,
              _sleep,
            ),
            titleBoard(size),
            adviceBoard(size),
            Space,
          ],
        ),
      ),
    );
  }

  ///---------------Function-----------------

  rebuild() {
    setState(() {});
  }

  callBack([dateTime]) async {
    if (_reports == null) _reports = await getKeyReport();
    _dateTime = dateTime ?? DateTime.now();
    _advices = await getAdvice(_dateTime);
    _heartRate = await getHeartRate(_dateTime);
    _sleep = await getSleep(_dateTime);
    if (mounted) setState(() {});
  }

  //this function won't trigger setState function, coz callback function will do it.
  Future weatherInformation() async {
    _weatherData = await getWeatherData();
    await getAirPollutionData(); //this will update value of airPollution.
    weather = _weatherData[widget.defaultIndex] ?? null;
    return true;
  }

  ///有效睡眠
  Future<String> getSleep(dateTime) async {
    final response2 = await widget.business.getDataWithType(
        DateTime(_dateTime.year, _dateTime.month, _dateTime.day)
            .millisecondsSinceEpoch,
        DateTime(_dateTime.year, _dateTime.month, _dateTime.day + 1)
            .millisecondsSinceEpoch,
        TypeOfData.HOURLY,
        FitKitType.SLEEP);
    final mins = response2.data['data'].length > 0
        ? Duration(
                milliseconds: (response2.data['data']?.first['inbedEndTime'] -
                    response2.data['data']?.first['inbedStartTime']))
            .inMinutes
        : null;
    return mins == null ? null : '${mins ~/ 60}小時${(mins % 60).floor()}分';
  }

  ///心率
  Future<String> getHeartRate(dateTime) async {
    try {
      final response1 = await widget.business.getDataWithType(
          DateTime(dateTime.year, dateTime.month, dateTime.day)
              .millisecondsSinceEpoch,
          DateTime(dateTime.year, dateTime.month, dateTime.day + 1)
              .millisecondsSinceEpoch,
          TypeOfData.DAILY,
          FitKitType.HEART_RATE);
      final toReturn = response1.data['data'].length > 0
          ? response1.data['data']?.first['maxValue']?.floor()?.toString()
          : null;
      return toReturn;
    } catch (e) {
      return null;
    }
  }

  ///宜忌
  Future getAdvice(dateTime) async {
    try {
      return await widget.dashboardRepository.fetchAdvices(dateTime);
    } catch (e) {
      return null;
    }
  }

  ///關鍵報告
  Future getKeyReport() async {
    Map<String, KeyReportDTO> toReturn;
    try {
      toReturn = await widget.dashboardRepository.getKeyReport();
      return toReturn;
    } catch (e) {
      return null;
    }
  }

  ///氣象資料
  Future<List<Location>> getWeatherData() async {
    Map<String, dynamic> queryParameters = {};
    queryParameters.putIfAbsent(
        'Authorization', () => 'CWB-43A139BB-B17A-4F2D-BC0A-20386318626D');
    queryParameters.putIfAbsent('elementName', () => 'WeatherDescription');
    try {
      return await widget.dio
          .get(
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-089',
        queryParameters: queryParameters,
      )
          .then(
        (response) {
          final data = response?.data['records']['locations'][0]['location'];
          List<String> cities = widget.airPollution.keys.toList();
          if (data is List)
            return data.map((v) {
              Location l = Location.fromJson(v); //預設顯示為新北市。
              return l;
            }).toList()
              ..sort(
                (a, b) => cities
                    .indexOf(a.locationName)
                    .compareTo(cities.indexOf(b.locationName)),
              ); //follow the order of cities to display.
          return null;
        },
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  ///空氣污染
  Future<void> getAirPollutionData() async {
    try {
      await widget.dio
          .get(
              'https://api.openaq.org/v1/measurements?country=TW&parameter[]=pm25')
          .then((response) {
        final data = response.data['results'];
        if (data is List) {
          data.forEach((json) {
            AirPollution air = AirPollution.fromJson(json);
            widget.airPollution.update(air.city, (originalValue) {
              if (originalValue == null) originalValue = [];
              originalValue.add(
                  air); //One city contains locations, so using a list to save them.
              return originalValue;
            });
          });
        }
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  ///---------------Widget-----------------

  Widget humanBody(Size size) {
    if (_reports == null)
      return SizedBox(
        height: 322,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    Map<String, KeyReportDTO> mapping = _reports;
    return Stack(
      children: <Widget>[
        Container(
          height: 322,
          width: 375,
          child: Image.asset(
            'assets/dashboard/img_onlybody@2x.png',
            fit: BoxFit.fill,
          ),
        ),
        Container(
          height: 322,
          width: 375,
          child: Image.asset(
            'assets/dashboard/img_body_line@2x.png',
            fit: BoxFit.fill,
          ),
        ),
        buttons(
            top: 10,
            left: 20,
            path: widget.imagePaths[mapping['stroke']?.severity?.toLowerCase()],
            keyReport: mapping['stroke'],
            title: '腦中風'),
        buttons(
            top: 80,
            left: 20,
            path: widget
                .imagePaths[mapping['SleepApnea']?.severity?.toLowerCase()],
            keyReport: mapping['SleepApnea'],
            title: '呼吸系統'),
        buttons(
            top: 145,
            left: 20,
            path: widget.imagePaths[mapping['ACS']?.severity?.toLowerCase()],
            keyReport: mapping['ACS'],
            title: '冠心症'),
        buttons(
            top: 210,
            left: 20,
            path: widget
                .imagePaths[mapping['FattyLiver']?.severity?.toLowerCase()],
            keyReport: mapping['FattyLiver'],
            title: '肝'),
        buttons(
            top: 280,
            left: 20,
            path: widget
                .imagePaths[mapping['Osteoporosis']?.severity?.toLowerCase()],
            keyReport: mapping['Osteoporosis'],
            title: '骨系統'),
        buttons(
            top: 10,
            right: 20,
            path: widget.imagePaths[mapping['CAIDE']?.severity?.toLowerCase()],
            keyReport: mapping['CAIDE'],
            title: '腦'),
        buttons(
            top: 80,
            right: 20,
            path:
                widget.imagePaths[mapping['Allergy']?.severity?.toLowerCase()],
            keyReport: mapping['Allergy'],
            title: '過敏'),
        buttons(
            top: 145,
            right: 20,
            path: widget
                .imagePaths[mapping['LiverCancer']?.severity?.toLowerCase()],
            keyReport: mapping['LiverCancer'],
            title: '肝癌'),
        buttons(
            top: 210,
            right: 20,
            path: widget.imagePaths[
                mapping['metabolicSyndrome']?.severity?.toLowerCase()],
            keyReport: mapping['metabolicSyndrome'],
            title: '代謝功能'),
        buttons(
            top: 280,
            right: 20,
            path: widget.imagePaths[
                mapping['ChronicKidneyDisease']?.severity?.toLowerCase()],
            keyReport: mapping['ChronicKidneyDisease'],
            title: '腎'),
      ],
    );
  }

  Widget buttons({
    double top,
    double left,
    double right,
    double bottom,
    String title,
    String path,
    KeyReportDTO keyReport,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: InkWell(
        onTap: () async {
          if (keyReport == null) return;
          final response = await widget.dashboardRepository
              .getKeyReportDetail(keyReport.keyCode);
          keyReport.title = title;
          keyReport.ruleName = response['ruleName'];
          keyReport.ruleDescription = response['ruleDescription'];
          keyReport.sugMsg = response['sugMsg'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => KeyReport(keyReport),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          height: 32,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: (keyReport == null)
                    ? Colors.grey
                    : Theme.of(context).accentColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title ?? '--',
                style: TextStyle(
                    color: (keyReport == null)
                        ? Colors.grey
                        : Theme.of(context).accentColor),
              ),
              Image.asset(
                path ?? '',
                height: 18,
                width: 18,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget healthInfo(
    size,
    _heartRate,
    String _sleep,
  ) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          heartRate(size, _heartRate),
          horizontalDivider(height: 70.0),
          sleep(size, _sleep),
//        stress(size),
        ],
      ),
    );
  }

  Widget heartRate(size, _heartRate) {
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          child: Image.asset('assets/dashboard/ic_heart_dashboard@2x.png'),
        ),
        Text(
          _heartRate ?? '--',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('下/分'),
      ],
    );
  }

  Widget sleep(size, String _sleep) {
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          child: Image.asset('assets/dashboard/ic_sleep_dashboard@2x.png'),
        ),
        Text(
          _sleep ?? '--',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('有效睡眠'),
      ],
    );
  }

  Widget stress(size) {
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          child: Image.asset('assets/dashboard/ic_stress_dashboard@2x.png'),
        ),
        Text(
          '--',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('壓力指數'),
      ],
    );
  }

  Widget titleBoard(size) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  '提供給您宜與忌',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.54)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget should(Size size, String suit) {
    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            child: Image.asset('assets/dashboard/ic_do@2x.png'),
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(suit ?? '--'),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget avoid(Size size, String taboo) {
    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            child: Image.asset('assets/dashboard/ic_dont@2x.png'),
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(taboo ?? '--'),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget adviceBoard(Size size) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          should(size, _advices?.suit),
          Divider(),
          avoid(size, _advices?.taboo),
        ],
      ),
    );
  }

  Widget horizontalDivider({num height, num width, Color color}) {
    return (Container(
      color: color ?? Colors.black.withOpacity(0.1),
      height: height ?? 30,
      width: width ?? 1,
      margin: EdgeInsets.symmetric(horizontal: 10),
    ));
  }

  Widget weatherBoard() {
    if (_weatherData == null || _weatherData.length <= 0) return SizedBox();
    //There's a issue, when the time is 11:57:xx,
    //and the api data start from 12:00:00, it will break.
    //so add one hour to avoid this issue.
    DateTime dateTime = DateTime.now().add(Duration(hours: 1));
    List<Widget> content = [];
    Time time;
    List<String> result = [];
    AirPollutionMapping airMap;
    List<AirPollution> air;

    if (weather != null &&
        weather.weatherElement != null &&
        weather.weatherElement.elementAt(0) != null &&
        weather.weatherElement.elementAt(0).time != null) {
      air = widget.airPollution[weather.locationName];
      if (air != null) airMap = AirPollutionMapping.init(air[0].value);
      weather.weatherElement[0].time.forEach((v) {
        if (DateTime.tryParse(v.startTime).isBefore(dateTime) &&
            DateTime.tryParse(v.endTime).isAfter(dateTime)) {
          time = v;
        }
      });
      time ??= weather.weatherElement[0].time[0];

      ///"多雲。降雨機率 0%。溫度攝氏22度。舒適。偏東風 平均風速2-3級(每秒4公尺)。相對濕度87%。"
      result = time.elementValue[0].value?.split('。');
      try {
        content.add(
          Expanded(
            child: Column(
              children: <Widget>[
                Image.asset(
                  widget.weatherImagePath[result[0]] ?? '',
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                ),
                Text(result[0]),
              ],
            ),
          ),
        );
        content.add(
          Expanded(
            child: Column(
              children: <Widget>[
                Text(result[1]),
                Text(result[2]),
                Text(result[5]),
              ],
            ),
          ),
        );
      } catch (e) {
        print(e);
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: DropdownButton<Location>(
              value: weather,
              isExpanded: true,
              items: _weatherData.map((value) {
                return DropdownMenuItem<Location>(
                  value: value,
                  child: Text(value.locationName),
                );
              }).toList(),
              onChanged: (index) {
                weather = index;
                setState(() {});
              },
            ),
          ),
          Row(
            children: content,
          ),
          Space,
          (air == null && air[0] == null)
              ? SizedBox()
              : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Text('空氣品質:${airMap.quality}'),
                        color: airMap.colors ?? null,
                      ),
                      Text('一般民眾:${airMap.suggestion}'),
                      Text('敏感族群:${airMap.sensitiveGroup}'),
                      Text(air[0].description()?.replaceAll('pm25', 'PM 2.5')),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
