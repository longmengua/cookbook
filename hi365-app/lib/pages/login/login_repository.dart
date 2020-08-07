import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi365/pages/login/index.dart';
import 'package:hi365/pages/login/user_info_model.dart';

class LoginRepository {
  final LoginProvider _loginProvider = LoginProvider();

  Future<UserDetailsModel> getUserInfo() => _loginProvider.getUserInfo();

  Future signInWithEmailAndPassword(String email, String password) =>
      _loginProvider.signInWithEmailAndPassword(email, password);

  Future<FirebaseUser> signInWithGoogle() => _loginProvider.signInWithGoogle();

  Future<FirebaseUser> signInWithApple() => _loginProvider.signInWithApple();
}
