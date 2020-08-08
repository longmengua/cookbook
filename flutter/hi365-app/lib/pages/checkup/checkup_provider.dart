import 'package:hi365/pages/checkup/index.dart';
import 'package:hi365/utils/api_provider.dart';

class CheckupProvider extends ApiProvider {
  final checkupBasePath = '/resource/api/user';

  Future<List<CheckupMaster>> getCheckupMaster() async {
    return await client
        .get('$checkupBasePath/healthCheckReport?page=1&start=0&limit=5')
        .then((response) {
      var data = response.data['data'];
      if (data == null) {
        return [];
      }
      return (data as List).map((d) => CheckupMaster.fromJson(d)).toList();
    });
  }

  Future<List<CheckupDetail>> getCheckupDetail(String reportId) async {
    return await client
        .get(
            '$checkupBasePath/healthCheckReportItem?healthCheckReportId=$reportId')
        .then((response) => (response.data['data'] as List)
            .map((d) => CheckupDetail.fromJson(d))
            .toList());
  }

  Future<List<CheckupDetail>> getCheckupDetailNew(String reportId) async {
    return await client
        .get(
            '$checkupBasePath/healthCheckReportItem/new?healthCheckReportId=$reportId')
        .then((response) {
      return (response.data['data'] as List)
          .map((d) => CheckupDetail.fromJson(d))
          .toList();
    }).catchError((err) {
      print(err);
    });
  }

  Future<List<CheckupInstitution>> getInstitutions() async {
    return await client
        .get('$checkupBasePath/healthCheckInterface/all')
        .then((response) {
      if (response.data['content'] == null) {
        return [];
      }
      return (response.data['content'] as List)
          .map((d) => CheckupInstitution.fromJson(d))
          .toList();
    });
  }

  Future<void> getReportFromSqureCastleBy(String hospitalId) async {
    await client.put('$checkupBasePath/squareCastle/synchronize/$hospitalId');
  }
}
