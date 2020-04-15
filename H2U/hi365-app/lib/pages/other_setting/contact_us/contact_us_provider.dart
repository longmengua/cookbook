import 'package:hi365/utils/api_provider.dart';

import 'contact_us_model.dart';

class ContactUsProvider extends ApiProvider {
  Future<String> saveContactUsInfo(ContactUsModel data) async {
    return client
        .post('/resource/api/user/contact', data: data.toJson())
        .then((response) {
      try {
        return 'success';
      } catch (e) {
        return 'Error causes with $e';
      }
    }).catchError((onError) {
      throw Exception(onError.response);
    });
  }

  Future<List<ContactUsModel>> getContactUsInfo() async {
    return client.get('/resource/api/user/contact').then((response) {
      try {
        var data = response.data['content'];
        return (data as List).map((v) => ContactUsModel.fromJson(v)).toList();
      } catch (e) {
        return [];
      }
    });
  }
}
