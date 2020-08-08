import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:hi365/pages/register/index.dart';
import 'package:hi365/utils/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  static final RegisterBloc _registerBlocSingleton = RegisterBloc._internal();
  factory RegisterBloc() {
    return _registerBlocSingleton;
  }
  RegisterBloc._internal();

  final RegisterRepository _registerRepository = RegisterRepository();

  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapSubmittedToState(event.email, event.password);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapSubmittedToState(
    String email,
    String password,
  ) async* {
    yield RegisterState.loading();
    try {
      await _registerRepository.createByEmailAndPassword(email, password);
      yield RegisterState.success(isSubmitting: true);
    } catch (e) {
      yield RegisterState.failure(e.message);
    }
  }
}
