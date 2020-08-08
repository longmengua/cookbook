import 'package:hi365/pages/personal_info/index.dart';
import 'package:hi365/pages/personal_info/personal_info_provider.dart';

class PersonalInfoRepository {
  final PersonalInfoProvider _personalInfoProvider = PersonalInfoProvider();

  PersonalInfoRepository();

  Future<PersonalInfo> fetch() async =>
      await _personalInfoProvider.getPersonalInfo();

  Future<void> update(PersonalInfo personalInfo) async =>
      await _personalInfoProvider.updatePersonalInfo(personalInfo);
}
