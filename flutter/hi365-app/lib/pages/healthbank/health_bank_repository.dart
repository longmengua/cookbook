import 'package:hi365/pages/healthbank/health_bank_provider.dart';
import 'package:hi365/pages/healthbank/healthbank_master_page.dart';

class HealthBankRepository {
  final HealthBankProvider _healthBankProvider = HealthBankProvider();

  HealthBankRepository();

  Future<List<HealthBankMaster>> fetchHealthBank() async =>
      await _healthBankProvider.fetchHealthBank();

  Future<int> countMasterFile() async =>
      await _healthBankProvider.countMasterFile();

  Future<void> uploadMHB(Map data) async =>
      await _healthBankProvider.uploadMHB(data);
}
