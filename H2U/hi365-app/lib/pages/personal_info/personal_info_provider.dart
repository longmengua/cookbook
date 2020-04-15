import 'dart:async';

import 'package:hi365/utils/api_provider.dart';

import 'index.dart';

class PersonalInfoProvider extends ApiProvider {
  Future<PersonalInfo> getPersonalInfo() async {
    return await client
        .get('/resource/api/user/personalInfo/')
        .then((response) => PersonalInfo.fromJson(response.data['data']));
  }

  Future<void> updatePersonalInfo(
    PersonalInfo personalInfo,
  ) async {
    return await client.put(
      '/resource/api/user/personalInfo/3345678',
      data: personalInfo,
    );
  }
}
