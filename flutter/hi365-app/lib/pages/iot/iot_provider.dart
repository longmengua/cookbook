part of iot;

class IotProvider extends ApiProvider {
  DateTime timezoneInfo = DateTime.now();

  Future save(String path, BaseInfo baseInfo) async {
    if (path == null || path == '') return null;
    return await client.post(path, data: baseInfo).then((response) {
      Map toReturn = response.data;
      return toReturn;
    });
  }

  Future latestDateTime(String path) async {
    if (path == null || path == '') return null;
    return await client.get(path).then((response) {
      Map toReturn = response.data;
      return toReturn;
    });
  }

  Future getData(
      {@required num startDate,
      @required num endDate,
      @required TypeOfData type,
      @required String path}) async {
    String des =
        '$path?startDate=$startDate&&endDate=$endDate&type=${describeEnum(type)}&zone=${timezoneInfo.timeZoneOffset.inHours}&zoneName=${timezoneInfo.timeZoneName}';
//    print(
//        '%% ${DateTime.fromMillisecondsSinceEpoch(startDate)} ~ ${DateTime.fromMillisecondsSinceEpoch(endDate)}');
    return await client.get(des);
  }

  Future getWeightDetail({
    @required num startDate,
    @required num endDate,
  }) async {
    return await client.get(
        '/resource/api/user/weight/list?startDate=$startDate&endDate=$endDate&type=BMI&zone=${timezoneInfo.timeZoneOffset.inHours}&zoneName=${timezoneInfo.timeZoneName}');
  }

  Future getGlucoseAverageDetail({
    @required num startDate,
    @required num endDate,
  }) async {
    return await client.get(
        '/resource/api/user/bloodGlucose/list?startDate=$startDate&endDate=$endDate&type=AVERAGE&zone=${timezoneInfo.timeZoneOffset.inHours}&zoneName=${timezoneInfo.timeZoneName}');
  }
}
