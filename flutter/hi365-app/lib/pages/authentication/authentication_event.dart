/// Author Zane Chen[zane.chen@h2uclub.com]
/// Create Date: 2019/081/5
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi365/pages/authentication/index.dart';
import 'package:hi365/pages/login/login_repository.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent {
  Future<AuthenticationState> getState({
    AuthenticationState currentState,
    AuthenticationBloc bloc,
  });

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final LoginRepository _loginRepository = LoginRepository();
}

/// Index Start
class AppStart extends AuthenticationEvent {
  @override
  String toString() => 'AppStart';

  @override
  Future<AuthenticationState> getState({
    AuthenticationState currentState,
    AuthenticationBloc bloc,
  }) async =>
      _runHandler(_getAuthenticationState);

  Future<AuthenticationState> _getAuthenticationState() async {
    FirebaseUser user = (await _authenticationRepository.isSignIn());
    return user == null ? Unauthenticated() : Authenticated(user: user);
  }
}

class SignInWithGoogle extends AuthenticationEvent {
  @override
  Future<AuthenticationState> getState({
    AuthenticationState currentState,
    AuthenticationBloc bloc,
  }) async =>
      _runHandler(_signInWithGoogle);

  Future<AuthenticationState> _signInWithGoogle() async {
    try {
      FirebaseUser user = await _loginRepository.signInWithGoogle();
      return user == null ? Unauthenticated() : Authenticated(user: user);
    } catch (e) {
      return Unauthenticated();
    }
  }
}

class SignInWithApple extends AuthenticationEvent {
  @override
  Future<AuthenticationState> getState({
    AuthenticationState currentState,
    AuthenticationBloc bloc,
  }) async =>
      _runHandler(_signInWithApple);

  Future<AuthenticationState> _signInWithApple() async {
    try {
      FirebaseUser user = await _loginRepository.signInWithApple();
      return user == null ? Unauthenticated() : Authenticated(user: user);
    } catch (e) {
      return Unauthenticated();
    }
  }
}

/// Logged In
class LoggedIn extends AuthenticationEvent {
  final FirebaseUser user;

  LoggedIn(this.user);

  @override
  Future<AuthenticationState> getState({
    AuthenticationState currentState,
    AuthenticationBloc bloc,
  }) async =>
      Authenticated(user: user);
}

/// Logged Out
class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LogOut';

  @override
  Future<AuthenticationState> getState({
    AuthenticationState currentState,
    AuthenticationBloc bloc,
  }) async =>
      _runHandler(_toLogOut);

  Future<AuthenticationState> _toLogOut() async {
    await _authenticationRepository.signOut();
    return Unauthenticated();
  }
}

class GoToLoginPage extends AuthenticationEvent {
  @override
  String toString() => 'GoToLoginPage';

  @override
  Future<AuthenticationState> getState({
    AuthenticationState currentState,
    AuthenticationBloc bloc,
  }) async =>
      AtLoginPage();
}

class GoToRegisterPage extends AuthenticationEvent {
  @override
  String toString() => 'GoToRegisterPage';

  @override
  Future<AuthenticationState> getState({
    AuthenticationState currentState,
    AuthenticationBloc bloc,
  }) async =>
      AtRegisterPage();
}

Future<AuthenticationState> _errorStateAndLogMessage(
  Exception e,
  StackTrace s,
) async {
  print('Exception:$e');
  print('Stacktrace:$s');
  return ErrorAuthentication(e?.toString());
}

Future<AuthenticationState> _runHandler(Function callback) async {
  try {
    return callback();
  } catch (e, s) {
    return _errorStateAndLogMessage(e, s);
  }
}

class GoToPhoneLoginPage extends AuthenticationEvent {
  @override
  String toString() => 'GoToPhoneLoginPage';

  @override
  Future<AuthenticationState> getState({
    AuthenticationState currentState,
    AuthenticationBloc bloc,
  }) async =>
      AtPhoneLogin();
}

class PhoneLoginSuccessfulState extends AuthenticationEvent {
  final FirebaseUser user;

  PhoneLoginSuccessfulState(this.user);

  @override
  String toString() => 'PhoneSuccessful';

  @override
  Future<AuthenticationState> getState({
    AuthenticationState currentState,
    AuthenticationBloc bloc,
  }) async {
    return user == null ? Unauthenticated() : Authenticated(user: user);
  }
}
