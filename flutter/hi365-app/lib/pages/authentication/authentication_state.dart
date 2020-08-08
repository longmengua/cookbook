import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {}

class Loading extends AuthenticationState {
  @override
  String toString() => 'Loading';

  @override
  List<Object> get props => null;
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';

  @override
  List<Object> get props => null;
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object> get props => null;
}

class Authenticated extends AuthenticationState {
  final FirebaseUser user;

  Authenticated({this.user});

  @override
  String toString() => 'Authenticated';

  @override
  List<Object> get props => null;
}

class AtLoginPage extends AuthenticationState {
  @override
  String toString() => 'InLoginPage';

  @override
  List<Object> get props => null;
}

class AtRegisterPage extends AuthenticationState {
  @override
  String toString() => 'InRegisterPage';

  @override
  List<Object> get props => null;
}

class ErrorAuthentication extends AuthenticationState {
  final String errorMessage;

  ErrorAuthentication(this.errorMessage);

  @override
  String toString() => 'ErrorAuthentication';

  @override
  List<Object> get props => [errorMessage];
}

class AtPhoneLogin extends AuthenticationState {
  @override
  String toString() => 'AtPhoneLogin';

  @override
  List<Object> get props => null;
}
