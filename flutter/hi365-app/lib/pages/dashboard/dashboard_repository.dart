import 'package:hi365/pages/dashboard/index.dart';
import 'package:hi365/pages/dashboard/dashboard_provider.dart';
import 'package:hi365/pages/dashboard/key_report/key_report_dto.dart';

class DashboardRepository {
  final DashboardProvider _dashboardProvider = DashboardProvider();

  DashboardRepository();

  Future<LunarCalenderAdvices> fetchAdvices([DateTime dateTime]) async {
    DateTime _dateTime = dateTime == null ? DateTime.now() : dateTime;
    return _dashboardProvider.getLunarCalendarAdvices(_dateTime);
  }

  Future<void> push() async {
    _dashboardProvider.post();
  }

  Future<Map<String,KeyReportDTO>> getKeyReport() async {
    return _dashboardProvider.getKeyReportDTO();
  }

  Future<Map> getKeyReportDetail(String keyCode) async {
    return _dashboardProvider.getKeyReportDetailDTO(keyCode);
  }
}
