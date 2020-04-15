import 'package:hi365/pages/checkup/index.dart';

class CheckupRepository {
  final CheckupProvider _checkupProvider = CheckupProvider();

  CheckupRepository();

  Future<List<CheckupMaster>> fetchMaster() async =>
      await _checkupProvider.getCheckupMaster();

  Future<List<CheckupDetail>> fetchDetail(String reportId) async =>
//      await _checkupProvider.getCheckupDetail(reportId);
      await _checkupProvider.getCheckupDetailNew(reportId);

  Future<List<CheckupInstitution>> fetchInsitutions() async =>
      await _checkupProvider.getInstitutions();

  Future<void> fetchHealthReport(String hospitalId) async =>
      await _checkupProvider.getReportFromSqureCastleBy(hospitalId);
}
