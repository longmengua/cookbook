import 'dart:ui';

/// Please generate by https://javiercbk.github.io/json_to_dart/
class LunarCalenderAdvices {
  int date;
  int lunarDay;
  int lunarMonth;
  int lunarYear;
  String suit;
  String taboo;

  LunarCalenderAdvices({
    this.date,
    this.lunarDay,
    this.lunarMonth,
    this.lunarYear,
    this.suit,
    this.taboo,
  });

  LunarCalenderAdvices.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    lunarDay = json['lunarDay'];
    lunarMonth = json['lunarMonth'];
    lunarYear = json['lunarYear'];
    suit = json['suit'];
    taboo = json['taboo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['lunarDay'] = this.lunarDay;
    data['lunarMonth'] = this.lunarMonth;
    data['lunarYear'] = this.lunarYear;
    data['suit'] = this.suit;
    data['taboo'] = this.taboo;
    return data;
  }

  @override
  String toString() {
    return 'LunarCalenderAdvices{date: $date, lunarDay: $lunarDay, lunarMonth: $lunarMonth, lunarYear: $lunarYear, suit: $suit, taboo: $taboo}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LunarCalenderAdvices &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          lunarDay == other.lunarDay &&
          lunarMonth == other.lunarMonth &&
          lunarYear == other.lunarYear &&
          suit == other.suit &&
          taboo == other.taboo;

  @override
  int get hashCode =>
      date.hashCode ^
      lunarDay.hashCode ^
      lunarMonth.hashCode ^
      lunarYear.hashCode ^
      suit.hashCode ^
      taboo.hashCode;
}

class Location {
  String locationName;
  String geocode;
  String lat;
  String lon;
  List<WeatherElement> weatherElement;
  AirPollution
      airPollution; //it's a additional field, not in response of weather api.

  Location(
      {this.locationName,
      this.geocode,
      this.lat,
      this.lon,
      this.weatherElement});

  Location.fromJson(Map<String, dynamic> json) {
    locationName = json['locationName'];
    geocode = json['geocode'];
    lat = json['lat'];
    lon = json['lon'];
    if (json['weatherElement'] != null) {
      weatherElement = new List<WeatherElement>();
      json['weatherElement'].forEach((v) {
        weatherElement.add(new WeatherElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationName'] = this.locationName;
    data['geocode'] = this.geocode;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    if (this.weatherElement != null) {
      data['weatherElement'] =
          this.weatherElement.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Location{locationName: $locationName, geocode: $geocode, lat: $lat, lon: $lon, weatherElement: $weatherElement}';
  }
}

class WeatherElement {
  String elementName;
  String description;
  List<Time> time;

  WeatherElement({this.elementName, this.description, this.time});

  WeatherElement.fromJson(Map<String, dynamic> json) {
    elementName = json['elementName'];
    description = json['description'];
    if (json['time'] != null) {
      time = new List<Time>();
      json['time'].forEach((v) {
        time.add(new Time.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['elementName'] = this.elementName;
    data['description'] = this.description;
    if (this.time != null) {
      data['time'] = this.time.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'WeatherElement{elementName: $elementName, description: $description, time: $time}';
  }
}

class Time {
  String startTime;
  String endTime;
  List<ElementValue> elementValue;

  Time({this.startTime, this.endTime, this.elementValue});

  Time.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
    if (json['elementValue'] != null) {
      elementValue = new List<ElementValue>();
      json['elementValue'].forEach((v) {
        elementValue.add(new ElementValue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    if (this.elementValue != null) {
      data['elementValue'] = this.elementValue.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Time{startTime: $startTime, endTime: $endTime, elementValue: $elementValue}';
  }
}

class ElementValue {
  String value;
  String measures;

  ElementValue({this.value, this.measures});

  ElementValue.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    measures = json['measures'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['measures'] = this.measures;
    return data;
  }

  @override
  String toString() {
    return 'ElementValue{value: $value, measures: $measures}';
  }
}

class AirPollution {
  String location;
  String parameter;
  Date date;
  int value;
  String unit;
  Coordinates coordinates;
  String country;
  String city;

  AirPollution(
      {this.location,
      this.parameter,
      this.date,
      this.value,
      this.unit,
      this.coordinates,
      this.country,
      this.city});

  AirPollution.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    parameter = json['parameter'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    value = json['value'];
    unit = json['unit'];
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
    country = json['country'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['parameter'] = this.parameter;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    data['value'] = this.value;
    data['unit'] = this.unit;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    data['country'] = this.country;
    data['city'] = this.city;
    return data;
  }

  String description() {
    if (this.parameter == null) return '';
    return '$parameter: $value $unit';
  }
}

class Date {
  String utc;
  String local;

  Date({this.utc, this.local});

  Date.fromJson(Map<String, dynamic> json) {
    utc = json['utc'];
    local = json['local'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['utc'] = this.utc;
    data['local'] = this.local;
    return data;
  }
}

class Coordinates {
  double latitude;
  double longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class AirPollutionMapping {
  final _range = [
    0, //0 ~ 50
    51, //51 ~ 100
    101, //101 ~ 151
    151, //151 ~ 201
    201, //201 ~ 300
    301, //300 ~
  ];

  final _quality = [
    '良好',
    '普通',
    '對敏感族群不健康',
    '對所有族群不健康',
    '非常不健康',
    '危害',
  ];

  final _suggestion = [
    '正常戶外活動。',
    '正常戶外活動。',
    '1.一般民眾如果有不適，如眼痛，咳嗽或喉嚨痛等，應該考慮減少戶外活動。2.學生仍可進行戶外活動，但建議減少長時間劇烈運動。',
    '1.一般民眾如果有不適，如眼痛，咳嗽或喉嚨痛等，應減少體力消耗，特別是減少戶外活動。2.學生應避免長時間劇烈運動，進行其他戶外活動時應增加休息時間。',
    '1.一般民眾應減少戶外活動。2.學生應立即停止戶外活動，並將課程調整於室內進行。',
    '1.一般民眾應避免戶外活動，室內應緊閉門窗，必要外出應配戴口罩等防護用具。2.學生應立即停止戶外活動，並將課程調整於室內進行。',
  ];

  final _sensitiveGroup = [
    '正常戶外活動。',
    '極特殊敏感族群建議注意可能產生的咳嗽或呼吸急促症狀，但仍可正常戶外活動。',
    '1.有心臟、呼吸道及心血管疾病患者、孩童及老年人，建議減少體力消耗活動及戶外活動，必要外出應配戴口罩。2.具有氣喘的人可能需增加使用吸入劑的頻率。',
    '1.有心臟、呼吸道及心血管疾病患者、孩童及老年人，建議留在室內並減少體力消耗活動，必要外出應配戴口罩。2.具有氣喘的人可能需增加使用吸入劑的頻率。',
    '1.有心臟、呼吸道及心血管疾病患者、孩童及老年人應留在室內並減少體力消耗活動，必要外出應配戴口罩。2.具有氣喘的人應增加使用吸入劑的頻率。',
    '1.有心臟、呼吸道及心血管疾病患者、孩童及老年人應留在室內並避免體力消耗活動，必要外出應配戴口罩。2.具有氣喘的人應增加使用吸入劑的頻率。',
  ];
  final _colors = [
    Color(0xff7BEA15),
    Color(0xffFDF731),
    Color(0xffEE7C33),
    Color(0xffE93F33),
    Color(0xff8F3F97),
    Color(0xff7F1F23),
  ];

  int _index = -1;

  AirPollutionMapping();

  AirPollutionMapping.init(int value){
//    AirPollutionMapping a = AirPollutionMapping();
    for (var v in this._range) {
      if(value > v)_index++;
    }
  }

  int get index => _index;

  get colors => _colors[_index];

  get sensitiveGroup => _sensitiveGroup[_index];

  get suggestion => _suggestion[_index];

  get quality => _quality[_index];

  get range => _range[_index];


}
