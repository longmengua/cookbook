import 'package:flutter/material.dart';

@immutable
class PersonalInfoState {
  final bool isUsernameValid;
  final bool isGenderValid;
  final bool isIDNumberValid;
  final bool isBirthdayValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  bool get isFormValid =>
      isGenderValid && isIDNumberValid && isUsernameValid && isBirthdayValid;

  PersonalInfoState({
    @required this.isUsernameValid,
    @required this.isGenderValid,
    @required this.isIDNumberValid,
    @required this.isBirthdayValid,
    @required this.isSubmitting,
    @required this.isFailure,
    @required this.isSuccess,
    this.errorMessage,
  });

  factory PersonalInfoState.empty() {
    return PersonalInfoState(
      isUsernameValid: false,
      isGenderValid: false,
      isIDNumberValid: false,
      isBirthdayValid: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory PersonalInfoState.loading() {
    return PersonalInfoState(
      isUsernameValid: true,
      isGenderValid: true,
      isIDNumberValid: true,
      isBirthdayValid: true,
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory PersonalInfoState.failure([
    String errorMessage,
  ]) {
    return PersonalInfoState(
      isUsernameValid: true,
      isGenderValid: true,
      isIDNumberValid: true,
      isBirthdayValid: true,
      isSubmitting: false,
      isFailure: true,
      isSuccess: false,
      errorMessage: errorMessage,
    );
  }

  factory PersonalInfoState.success() {
    return PersonalInfoState(
      isUsernameValid: true,
      isGenderValid: true,
      isIDNumberValid: true,
      isBirthdayValid: true,
      isSubmitting: false,
      isFailure: false,
      isSuccess: true,
    );
  }

  PersonalInfoState update({
    bool isUsernameValid,
    bool isGenderValid,
    bool isIDNumberValid,
    bool isBirthdayValid,
  }) {
    return copyWith(
      isUsernameValid: isUsernameValid,
      isGenderValid: isGenderValid,
      isIDNumberValid: isIDNumberValid,
      isBirthdayValid: isBirthdayValid,
      isLoading: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  PersonalInfoState copyWith({
    bool isUsernameValid,
    bool isGenderValid,
    bool isIDNumberValid,
    bool isBirthdayValid,
    bool isLoading,
    bool isSuccess,
    bool isFailure,
  }) {
    return PersonalInfoState(
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isGenderValid: isGenderValid ?? this.isGenderValid,
      isIDNumberValid: isIDNumberValid ?? this.isIDNumberValid,
      isBirthdayValid: isBirthdayValid ?? this.isBirthdayValid,
      isSubmitting: isLoading ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''PersonalInfoState {
      isUsernameValid: $isUsernameValid,
      isGenderValid: $isGenderValid,
      isIDNumberValid: $isIDNumberValid,
      isBirthdayValid: $isBirthdayValid,
      isLoading: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      errorMessage: $errorMessage,
    }
    ''';
  }
}
