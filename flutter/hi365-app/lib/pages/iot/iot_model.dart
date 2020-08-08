part of 'index.dart';

class BaseInfo<T extends DataInterface> {
  String source;
  String sourceName;
  String hardware;
  String software;
  String manufacturer;
  String name;
  List data;

  BaseInfo(
      {this.source,
      this.sourceName,
      this.hardware,
      this.software,
      this.manufacturer,
      this.name,
      this.data});

  BaseInfo.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    sourceName = json['sourceName'];
    hardware = json['hardware'];
    software = json['software'];
    manufacturer = json['manufacturer'];
    name = json['name'];
    if (json['data'] != null) {
      data = new List<DataInterface>();
      json['data'].forEach((v) {
        data.add(new HealthDetail().fromJson(jsonOne: v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['sourceName'] = this.sourceName;
    data['hardware'] = this.hardware;
    data['software'] = this.software;
    data['manufacturer'] = this.manufacturer;
    data['name'] = this.name;
    if (this.data != null) {
      data['data'] = this.data.map((one) {
        return one.toJson();
      }).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'BaseInfo{source: $source, sourceName: $sourceName, hardware: $hardware, software: $software, manufacturer: $manufacturer, name: $name, data: $data}';
  }
}

class HealthDetail extends DataInterface {
  num startDate;
  num endDate;
  String unit;
  num value;

  HealthDetail({this.startDate, this.endDate, this.unit, this.value});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['unit'] = this.unit ?? '';
    data['value'] = this.value;
    return data;
  }

  @override
  fromJson({Map jsonOne, Map jsonTwo}) {
    return HealthDetail(
      startDate: jsonOne['date_from'],
      endDate: jsonOne['date_to'],
      unit: jsonOne['unit'],
      value: jsonOne['value'],
    );
  }

  @override
  String toString() {
    return 'HealthDetail{startDate: $startDate, endDate: $endDate, unit: $unit, value: $value}';
  }
}

class BloodPressureDetail extends DataInterface {
  num startDate;
  num endDate;
  String unit;
  num systolic; //max
  num diastolic; //min

  BloodPressureDetail(
      {this.startDate, this.endDate, this.unit, this.systolic, this.diastolic});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['unit'] = this.unit;
    data['systolic'] = this.systolic;
    data['diastolic'] = this.diastolic;
    return data;
  }

  @override
  fromJson({Map jsonOne, Map jsonTwo}) {
    return BloodPressureDetail(
      startDate: jsonOne['date_from'],
      endDate: jsonOne['date_to'],
      unit: jsonOne['unit'] ?? '',
      systolic: jsonTwo['value'],
      diastolic: jsonOne['value'],
    );
  }

  @override
  String toString() {
    return 'BloodPressureDetail{startDate: $startDate, endDate: $endDate, unit: $unit, systolic: $systolic, diastolic: $diastolic}';
  }
}

class Item {
  String title;
  FitKitType type;
  List<String> detailTitle;
  List<String> detailUnit;
  bool additionalButton;
  Color color;

  Item(
      {this.title,
      this.type,
      this.detailTitle,
      this.detailUnit,
      this.additionalButton,
      this.color});
}

class Glucose extends DataInterface {
  num startDate;
  num endDate;
  String unit;
  num value;
  String mealType;
  String dining;

  Glucose();

  Glucose.fromJson(
      {this.startDate,
      this.endDate,
      this.unit,
      this.value,
      this.mealType,
      this.dining});

  @override
  String toString() {
    return 'Glucose{startDate: $startDate, endDate: $endDate, unit: $unit, value: $value, dining: $dining, mealType: $mealType}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['unit'] = this.unit;
    data['value'] = this.value;
    data['dining'] = this.dining;
    data['mealType'] = this.mealType;
    return data;
  }

  @override
  fromJson({Map jsonOne, Map jsonTwo}) {
    return Glucose.fromJson(
      startDate: jsonOne['startDate'],
      endDate: jsonOne['endDate'],
      unit: jsonOne['unit'] ?? '',
      value: jsonOne['value'],
      mealType: jsonOne['mealType'],
      dining: jsonOne['dining'],
    );
  }
}

class DetailOnChartPoint {
  bool _show = false;
  DateTime _dateTime;

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    _dateTime = value;
  }

  List<num> _values = [];

  bool get show => _show;

  set show(bool value) {
    _show = value;
  }

  List<num> get values => _values;

  set values(List<num> value) {
    _values = value;
  }
}
