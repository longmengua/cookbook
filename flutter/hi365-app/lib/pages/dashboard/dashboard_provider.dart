import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hi365/pages/dashboard/key_report/key_report_dto.dart';
import 'package:hi365/utils/api_provider.dart';

import 'dashboard_model.dart';

class DashboardProvider extends ApiProvider {
  Future<LunarCalenderAdvices> getLunarCalendarAdvices(
      DateTime dateTime) async {
    return client
        .get('/resource/api/client/lunar/${dateTime.millisecondsSinceEpoch}')
        .then(
            (response) => LunarCalenderAdvices.fromJson(response.data['data']));
  }

  Future<void> post() async {}

  Future<Map<String, KeyReportDTO>> getKeyReportDTO() async {
    return client
        .get('/resource/api/user/keyreport/newfindAllLatestKeyReport/HRA')
        .then((response) {
      if (response.statusCode != 200) return null;
      Map<String, KeyReportDTO> toReturn = {};
      (response.data as List).forEach((v) {
        KeyReportDTO _k = KeyReportDTO.fromJson(v);
        toReturn.putIfAbsent(_k.ruleId, () => _k);
      });
      return toReturn;
    });
  }

  Future<Map> getKeyReportDetailDTO(String keyCode) async {
    return client
        .get(
            '/resource/api/user/keyreport/getnewLastRunPreHRAReport/HRA/$keyCode')
        .then((response) {
      if (response.statusCode != 200) return null;
      return response.data['hra']['hraResults'][0];
    });
  }
}
