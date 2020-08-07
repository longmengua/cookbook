import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi365/pages/authentication/index.dart';

class AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider();

  Future<void> signOut() => _authenticationProvider.toLogoutUser();

  Future<FirebaseUser> isSignIn() => _authenticationProvider.toCheckUserIsExisted();
}
