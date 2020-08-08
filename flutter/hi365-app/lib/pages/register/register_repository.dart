import 'package:hi365/pages/register/index.dart';
import 'package:hi365/pages/register/register_provider.dart';

class RegisterRepository {
  final RegisterProvider _registerProvider = RegisterProvider();

  Future<void> createByEmailAndPassword(
    String email,
    String password,
  ) async =>
      _registerProvider.register(email, password);
}
