import 'package:flutter/material.dart';

@immutable
class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  bool get isFormValid => isEmailValid && isPasswordValid;

  RegisterState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isFailure,
    @required this.isSuccess,
    @required this.errorMessage,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isEmailValid: false,
      isPasswordValid: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
      errorMessage: null,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
      errorMessage: null,
    );
  }

  factory RegisterState.failure(
    String errorMessage,
  ) {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isFailure: true,
      isSuccess: false,
      errorMessage: errorMessage,
    );
  }

  factory RegisterState.success({
    bool isSubmitting,
  }) {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: isSubmitting ?? false,
      isFailure: false,
      isSuccess: true,
      errorMessage: null,
    );
  }

  RegisterState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isLoading: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isLoading,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isLoading ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: this.errorMessage,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isLoading: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      errorMessage: $errorMessage,
    }
    ''';
  }
}
