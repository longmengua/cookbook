import 'package:hi365/pages/other_setting/personalInfo/personal_model.dart';
import 'package:hi365/utils/api_provider.dart';

class PersonalProvider extends ApiProvider {
  Future<PersonalModel> getPersonalInfo() async {
    return await client
        .get('/resource/api/user/user/personalInfo')
        .then((response) {
      return PersonalModel.fromJson(response.data);
    }).catchError((onError) {
      throw Exception(onError.response);
    });
  }

  Future<bool> updatePersonalInfo(PersonalModel personalModel) async {
    return await client
        .post('/resource/api/user/user/personalInfo', data: personalModel)
        .then((response) {
      return response.data;
    }).catchError((onError) {
      throw Exception(onError.response);
    });
  }

  Future<String> signingPrivacyPolicy() async {
    return await client.post('/resource/api/user/policy').then((response) {
      return response?.data?.toString()?.toLowerCase();
    }).catchError((onError) {
      throw Exception(onError.response);
    });
  }

  Future<String> didSignPrivacyPolicy() async {
    return await client.get('/resource/api/user/policy').then((response) {
      return response?.data?.toString()?.toLowerCase();
    }).catchError((onError) {
      throw Exception(onError.response);
    });
  }

  Future<String> privacyPolicyPaper() async {
    return await client
        .get('/resource/api/user/policy/sign/default')
        .then((response) {
      return response?.data?.toString();
    }).catchError((onError) {
      throw Exception(onError.response);
    });
  }
}
