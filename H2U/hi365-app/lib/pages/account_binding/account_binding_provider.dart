import 'dart:async';

import 'package:hi365/pages/account_binding/account_binding_model.dart';
import 'package:hi365/utils/api_provider.dart';
import 'package:hi365/utils/api_response.dart';

class AccountBindingProvider extends ApiProvider {
  Future<ApiResponse> toBindingWithCompany(BindingInfo bindingInfo) async =>
      await client
          .post('/resource/api/user/accountInfo/binding', data: bindingInfo)
          .then((response) => ApiResponse.fromJson(response.data));
}
