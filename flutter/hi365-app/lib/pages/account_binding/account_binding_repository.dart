import 'package:hi365/pages/account_binding/index.dart';
import 'package:hi365/pages/account_binding/account_binding_provider.dart';
import 'package:hi365/utils/api_response.dart';

class AccountBindingRepository {
  final AccountBindingProvider _accountBindingProvider =
      AccountBindingProvider();

  Future<ApiResponse> push(BindingInfo bindingInfo) async =>
      await _accountBindingProvider.toBindingWithCompany(bindingInfo);
}
