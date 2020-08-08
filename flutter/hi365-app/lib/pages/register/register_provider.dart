import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hi365/utils/api_provider.dart';

class RegisterProvider extends ApiProvider {
  Future<void> register(
    String email,
    String password,
  ) async {
    try {
      await signUpWithEmailAndPassword(email, password);
    } catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        throw DioError(error: '此帳號已註冊');
      } else {
        throw DioError(error: '請稍候再試');
      }
    }
  }
}
