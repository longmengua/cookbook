import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi365/utils/api_provider.dart';

class AuthenticationProvider extends ApiProvider {
  Future<FirebaseUser> toCheckUserIsExisted() async => await isUserExisted;

  Future<void> toLogoutUser() async => await signOut();
}
