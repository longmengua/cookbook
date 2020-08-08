import 'package:flutter/material.dart';

// Template 1
@immutable
class AccountBindingState {
  final bool isAccountInfoNameValid;
  final bool isBirthdayValid;
  final bool isUsernameValid;
  final bool isOrganizationValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  bool get isFormValid =>
      isAccountInfoNameValid &&
      isBirthdayValid &&
      isUsernameValid &&
      isOrganizationValid;

  AccountBindingState({
    @required this.isAccountInfoNameValid,
    @required this.isBirthdayValid,
    @required this.isUsernameValid,
    @required this.isOrganizationValid,
    @required this.isSubmitting,
    @required this.isFailure,
    @required this.isSuccess,
    this.errorMessage,
  });

  factory AccountBindingState.empty() {
    return AccountBindingState(
      isAccountInfoNameValid: false,
      isBirthdayValid: false,
      isUsernameValid: false,
      isOrganizationValid: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory AccountBindingState.loading() {
    return AccountBindingState(
      isAccountInfoNameValid: true,
      isBirthdayValid: true,
      isUsernameValid: true,
      isOrganizationValid: true,
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory AccountBindingState.failure(
    String errorMessage,
  ) {
    return AccountBindingState(
      isAccountInfoNameValid: true,
      isBirthdayValid: true,
      isUsernameValid: true,
      isOrganizationValid: true,
      isSubmitting: false,
      isFailure: true,
      isSuccess: false,
      errorMessage: errorMessage,
    );
  }

  factory AccountBindingState.success() {
    return AccountBindingState(
      isAccountInfoNameValid: true,
      isBirthdayValid: true,
      isUsernameValid: true,
      isOrganizationValid: true,
      isSubmitting: false,
      isFailure: false,
      isSuccess: true,
    );
  }

  AccountBindingState update({
    bool isAccountInfoNameValid,
    bool isBirthdayValid,
    bool isUsernameValid,
    bool isOrganizationValid,
  }) {
    return copyWith(
      isAccountInfoNameValid: isAccountInfoNameValid,
      isBirthdayValid: isBirthdayValid,
      isUsernameValid: isUsernameValid,
      isOrganizationValid: isOrganizationValid,
      isLoading: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  AccountBindingState copyWith({
    bool isAccountInfoNameValid,
    bool isBirthdayValid,
    bool isUsernameValid,
    bool isOrganizationValid,
    bool isLoading,
    bool isSuccess,
    bool isFailure,
  }) {
    return AccountBindingState(
      isAccountInfoNameValid:
          isAccountInfoNameValid ?? this.isAccountInfoNameValid,
      isBirthdayValid: isBirthdayValid ?? this.isBirthdayValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isOrganizationValid: isOrganizationValid ?? this.isOrganizationValid,
      isSubmitting: isLoading ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''AccountBindingState {
      isAccountInfoNameValid: $isAccountInfoNameValid,
      isBirthdayValid: $isBirthdayValid,
      isUsernameValid: $isUsernameValid,
      isOrganizationValid: $isOrganizationValid,
      isLoading: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }
    ''';
  }
}

// Template 2
// If you want to use this template, please remove template 1
// and uncomment below expressions.
// @immutable
// abstract class AccountBindingState extends Equatable {
//   AccountBindingState([List props = const <dynamic>[]]) : super(props);
// }
//
// class InitialAccountBinding extends AccountBindingState {
//   @override
//   String toString() => 'InitialAccountBinding';
// }
//
// class LoadingAccountBinding extends AccountBindingState {
//   @override
//   String toString() => 'LoadingAccountBinding';
// }
//
// class InitializedAccountBinding extends AccountBindingState {
//   @override
//   String toString() => 'InitializedAccountBinding';
// }
//
// class ErrorAccountBinding extends AccountBindingState {
//   ErrorAccountBinding({this.errorMessage});
//
//   final String errorMessage;
//
//   @override
//   String toString() => 'ErrorAccountBinding : $errorMessage';
// }
