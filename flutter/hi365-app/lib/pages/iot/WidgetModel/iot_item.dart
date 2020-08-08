part of '../index.dart';

class ItemBuilder {
  static num length = healthInfo.length;

  static List<Item> healthInfo = [
    Item(
      title: '心率',
      type: FitKitType.HEART_RATE,
      detailTitle: ['最高心率', '最低心率'],
      detailUnit: ['下/分', '下/分'],
      color: Color(0xffEB5677),
    ),
    Item(
      title: '血壓',
      type: FitKitType.BLOOD_PRESSURE,
      detailTitle: ['最高收縮壓', '最低舒張壓'],
      detailUnit: ['mmHg', 'mmHg'],
      color: Color(0xffEE6F6F),
    ),
    Item(
      title: '活動',
      type: FitKitType.ACTIVITY,
      detailTitle: ['步數#', '卡路里#'],
      detailUnit: ['步', '大卡'],
      color: Color(0xff568BEB),
    ),
    Item(
      title: '睡眠',
      type: FitKitType.SLEEP,
      detailTitle: ['睡眠品質#', '睡眠時間#'],
      detailUnit: ['%', '分'],
      color: Color(0xff7B56EB),
    ),
    Item(
      title: '體重',
      type: FitKitType.WEIGHT,
      detailTitle: ['體重(平均)'],
      detailUnit: ['公斤'],
      color: Color(0xffFE9500),
    ),
    Item(
      //
      title: '血糖',
      type: FitKitType.BLOOD_SUGAR,
      detailTitle: [
        '最高血糖',
        '最低血糖',
      ],
      detailUnit: [
        'mg/dl',
        'mg/dl',
      ],
      additionalButton: true,
      color: Color(0xffCA4B4B),
    ),
  ];

  List<Widget> detailText(List details, FitKitType type,
      {int length, Period period}) {
    List<Widget> toReturn = [];
    if (details == null) return toReturn..add(Text(''));
    details.forEach((value) {
      if (value != null && (value as String).contains('#')) {
        switch (period) {
          case Period.Day:
            String tmp = type == FitKitType.SLEEP ? '' : '(總和)';
            value = value.replaceAll('#', tmp);
            break;
          case Period.Week:
            value = value.replaceAll('#', '(日)');
            break;
          case Period.Month:
            value = value.replaceAll('#', '(日)');
            break;
          case Period.Year:
            value = value.replaceAll('#', '(月)');
            break;
          default:
            value = value.replaceAll('#', '');
            break;
        }
      }
      toReturn.add(Text(value ?? '', style: TextStyle(color: Colors.white)));
    });
    if (length != null)
      for (int i = toReturn.length; i < length; i++) {
        toReturn.add(Text('--', style: TextStyle(color: Colors.white)));
      }
    return toReturn;
  }

  _title(String title) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 25, color: Colors.white),
    );
  }

  _content(
      {List detailTitle,
      List detailContent,
      List detailUnit,
      Period period,
      FitKitType type}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: detailText(detailTitle, type, period: period),
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Column(
              children:
                  detailText(detailContent, type, length: detailTitle.length),
            ),
          ),
          Column(
            children: detailText(detailUnit, type),
          ),
        ],
      ),
    );
  }
}
