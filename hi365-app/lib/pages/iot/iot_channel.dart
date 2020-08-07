part of 'index.dart';

abstract class DataInterface<T> {
  Map<String, dynamic> toJson();
  T fromJson({Map jsonOne, Map jsonTwo});
}

class Channel {
  ///channel
  static const platform = const MethodChannel('com.h2uclub.hi365/health');

  static Future<bool> permissionsRequest() async {
    print('#####Health channl(permissionsRequest sent.)');
    return await platform.invokeMethod('requestPermissions', {
      "types": [
        "heart_rate",
        "step_count",
        "weight",
        "blood_systolic",
        "blood_diastolic",
        "sleep",
      ]
    });
  }

  static Future<List> read(
    HealthType type,
    DateTime dateFrom,
    DateTime dateTo,
  ) async {
    return await platform.invokeListMethod('read', {
      "type": _healthTypeToString(type),
      "date_from": dateFrom.millisecondsSinceEpoch,
      "date_to": dateTo.millisecondsSinceEpoch,
    }).then((response) {
      List toReturn = response.map((item) {
        return HealthDetail().fromJson(jsonOne: item);
      }).toList();
      return toReturn ?? [];
    });
  }

  static Future<List> readBloodPressure(
    DateTime dateFrom,
    DateTime dateTo,
  ) async {
    return await platform.invokeListMethod('read', {
      "type": "blood_diastolic",
      "date_from": dateFrom.millisecondsSinceEpoch,
      "date_to": dateTo.millisecondsSinceEpoch,
    }).then((responseOne) async {
      return await platform.invokeListMethod('read', {
        "type": "blood_systolic",
        "date_from": dateFrom.millisecondsSinceEpoch,
        "date_to": dateTo.millisecondsSinceEpoch,
      }).then((responseTwo) {
        List<BloodPressureDetail> toReturn = [];

        ///Currently, use the responseOne length as base line.
        for (int i = 0; i < responseOne.length; i++) {
          toReturn.add(BloodPressureDetail()
              .fromJson(jsonOne: responseOne[i], jsonTwo: responseTwo[i]));
        }
        return toReturn;
      });
    });
  }

  static String _healthTypeToString(HealthType type) {
    switch (type) {
      case HealthType.HEART_RATE:
        return "heart_rate";
      case HealthType.STEP_COUNT:
        return "step_count";
      case HealthType.WEIGHT:
        return "weight";
      case HealthType.SLEEP:
        return "sleep";
      case HealthType.BLOOD_PRESSURE:
        break;
    }
    throw Exception('HealthType $type not supported');
  }
}
