part of 'index.dart';

///for methods
class Business {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Map deviceInfoMap;

  Business() {
    iotProvider = IotProvider();
  }

  IotProvider iotProvider;

  ///fetch data from app, save to the backend.
  fetchFromNativeApp(
      HealthType healthType, DateTime dateFrom, DateTime dateTo) async {
    if (healthType == HealthType.BLOOD_PRESSURE) {
      await Channel.readBloodPressure(dateFrom, dateTo).then((result) async {
        await saveDataToBackend(result, healthType);
      });
    } else {
      await Channel.read(
        healthType,
        dateFrom,
        dateTo,
      ).then((result) async {
        await saveDataToBackend(result, healthType);
      });
    }
  }

  ///get the latest date time of the data.
  getLatestDateTime(HealthType healthType) async {
    DateTime toReturn;
    String path = '${postDataPath(healthType)}?page=1&limit=1';
    try {
      final response = await iotProvider.latestDateTime(path);
      final data = response['data'][0];
      toReturn = DateTime.fromMillisecondsSinceEpoch(
              data[mappingDateName(healthType)]) ??
          DateTime.now();
    } catch (e) {
      print(e);
    }
    return toReturn;
  }

  String mappingDateName(HealthType healthType) {
    switch (healthType) {
      case HealthType.HEART_RATE:
      case HealthType.BLOOD_PRESSURE:
      case HealthType.SLEEP:
      case HealthType.WEIGHT:
      case HealthType.STEP_COUNT:
        return 'startDate';
      default:
        return '';
    }
  }

  ///Paths are for saving data in backend, and to be used by get latest date time of data.
  String postDataPath(HealthType healthType) {
    switch (healthType) {
      case HealthType.HEART_RATE:
        return '/resource/api/user/heartRate';
      case HealthType.BLOOD_PRESSURE:
        return '/resource/api/user/bloodPressure';
      case HealthType.STEP_COUNT:
        return '/resource/api/user/step';
      case HealthType.WEIGHT:
        return '/resource/api/user/weight';
      case HealthType.SLEEP:
        return '/resource/api/user/sleep';
      default:
        return '';
    }
  }

  ///Paths are getting data from backend,
  String getDataPath(FitKitType fitKitType) {
    switch (fitKitType) {
      case FitKitType.HEART_RATE:
        return '/resource/api/user/heartRate/list';
      case FitKitType.BLOOD_PRESSURE:
        return '/resource/api/user/bloodPressure/list';
      case FitKitType.SLEEP:
        return '/resource/api/user/sleep/list';
      case FitKitType.WEIGHT:
        return '/resource/api/user/weight/list';
      case FitKitType.BLOOD_SUGAR:
        return '/resource/api/user/bloodGlucose/list';
      case FitKitType.ACTIVITY:
        return '/resource/api/user/step/list';
      default:
        return '';
        break;
    }
  }

  Future<Map> _getDeviceInfo() async {
    IosDeviceInfo iosInfo;
    AndroidDeviceInfo androidInfo;
    String deviceName;
    String deviceVersion;

    String source;
    String sourceName;
    String hardware;
    String software;
    String manufacturer;
    String name;
    if (DeviceInfo.Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      source = 'Andorid';
      sourceName = 'GoogleFit';
      hardware = '${androidInfo.device}';
      software = 'Android ${androidInfo.version.release}';
      manufacturer = '${androidInfo.manufacturer}';
      name = androidInfo.androidId;
    } else if (DeviceInfo.Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
      source = 'Iphone';
      sourceName = 'HealthKit';
      hardware = '${iosInfo.model}';
      software = '${iosInfo.systemName} ${iosInfo.systemVersion}';
      manufacturer = 'Apple';
      name = iosInfo.identifierForVendor;
    }
    return {
      'source': source,
      'sourceName': sourceName,
      'hardware': hardware,
      'software': software,
      'manufacturer':manufacturer,
      'name': name,
    };
  }

  saveGlucoseToBackground(Glucose glucose) async {
    if (deviceInfoMap == null) deviceInfoMap = await _getDeviceInfo();
    List data = [];
    data.add(glucose);
    await iotProvider.save(
        '/resource/api/user/bloodGlucose',
        BaseInfo<Glucose>(
          source: deviceInfoMap['source'],
          sourceName: deviceInfoMap['sourceName'],
          hardware: deviceInfoMap['hardware'],
          software: deviceInfoMap['software'],
          manufacturer: deviceInfoMap['manufacturer'],
          name: deviceInfoMap['name'],
          data: data,
        ));
  }

  ///Divide it into several part to push to background.
  saveDataToBackend(List result, HealthType healthType) async {
    if (deviceInfoMap == null) deviceInfoMap = await _getDeviceInfo();
    String path = postDataPath(healthType);
    int amount = 500;
    try {
      print('#####$healthType[total:${result.length}]\n');
      for (int i = 0; i < result.length; i += amount) {
        int start = i;
        int end = i + amount;
        if (end > result.length) end = result.length;
        print('#####$healthType[$start ~ $end]\n');
        await iotProvider.save(
            path,
            BaseInfo<HealthDetail>(
              source: deviceInfoMap['source'],
              sourceName: deviceInfoMap['sourceName'],
              hardware: deviceInfoMap['hardware'],
              software: deviceInfoMap['software'],
              manufacturer: deviceInfoMap['manufacturer'],
              name: deviceInfoMap['name'],
              data: result.sublist(start, end) ?? [],
            ));

        ///for postponing the time gap between requests.
//        await Future.delayed(const Duration(seconds: 3));
      }
    } catch (e) {
      print('Error cause in $e');
    }
  }

  Future getDataWithType(num startDate, num endDate, TypeOfData type,
      FitKitType fitKitType) async {
    String path = getDataPath(fitKitType);
    return await iotProvider.getData(
      startDate: startDate,
      endDate: endDate,
      type: type,
      path: path,
    );
  }

  Future getDataWithGlucose(num startDate, num endDate) async {
    String path = '/resource/api/user/bloodGlucose/list';
    TypeOfData type = TypeOfData.DETAIL;
    return await iotProvider.getData(
      startDate: startDate,
      endDate: endDate,
      type: type,
      path: path,
    );
  }

  mappingType(Period period) {
    switch (period) {
      case Period.Day:
        return TypeOfData.HOURLY;
        break;
      case Period.Week:
      case Period.Month:
        return TypeOfData.DAILY;
        break;
      case Period.Year:
        return TypeOfData.MONTHLY;
        break;
    }
  }

  Future getWeightDetail(
    num startDate,
    num endDate,
  ) async {
    return await iotProvider.getWeightDetail(
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future getGlucoseAverageDetail(
    num startDate,
    num endDate,
  ) async {
    return await iotProvider.getGlucoseAverageDetail(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
