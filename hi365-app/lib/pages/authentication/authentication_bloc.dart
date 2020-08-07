import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi365/pages/authentication/index.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  // ignore: close_sinks
  static final AuthenticationBloc _authenticationBlocSingleton =
      AuthenticationBloc._internal();
  factory AuthenticationBloc() => _authenticationBlocSingleton;
  AuthenticationBloc._internal();

  AuthenticationState get initialState => Uninitialized();

  FirebaseUser user;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    try {
      if (event is SignInWithGoogle || event is SignInWithApple) {
        yield Loading();
      }
      AuthenticationState authenticationState =
          await event.getState(currentState: state, bloc: this);
      if (authenticationState is Authenticated) user = authenticationState.user;
      // print(user?.email);
      // print(user?.phoneNumber);
      // print(user?.providerData?.first?.providerId);
      yield authenticationState;
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }
}
