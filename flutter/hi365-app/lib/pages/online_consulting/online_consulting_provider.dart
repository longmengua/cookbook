import 'package:dio/dio.dart';
import 'package:hi365/utils/api_provider.dart';

import 'online_consulting_model.dart';

class OnlineConsultingProvider extends ApiProvider {
  Future<List<OnlineConsulting>> getCouponByGovId(String govId) {
    return client
        .get('/resource/api/onlineConsulting/coupon/$govId')
        .then((response) {
      if (response.statusCode != 200 || response.data['data'] == null)
        return null;
      return (response.data['data'] as List)
          .map((d) => OnlineConsulting.fromJson(d))
          .toList();
    });
  }

  Future<OnlineConsulting> bindCouponWithGovId(String govId, String key) {
    return client.post('/resource/api/onlineConsulting/coupon/bind',
        data: {"gid": govId, "key": key}).then((response) {
      if (response.statusCode != 200 || response.data['data'] == null)
        return null;
      return OnlineConsulting.fromJson(response.data['data']);
    });
  }

  Future<OnlineConsultingRecord> startDial(String govId, String key) {
    return client.post('/resource/api/onlineConsulting/dial',
        data: {"gid": govId, "key": key}).then((response) {
      if (response.statusCode != 200 || response.data['data'] == null)
        return null;
      return OnlineConsultingRecord.fromJson(response.data['data']);
    });
  }

  Future<void> sendGovID(String token, String govId) async {
    return await Dio().post('https://${token}.ngrok.io/gid', data: {
      'id': govId,
    }).then((response) => print('GovID has sent: $govId'));
  }

  Future<OnlineConsultingRoom> getRoom() {
    return client.get('/resource/api/onlineConsulting/room').then((response) {
      if (response.statusCode != 200 || response.data['data'] == null)
        return null;
      return OnlineConsultingRoom.fromJson(response.data['data']);
    });
  }
}
