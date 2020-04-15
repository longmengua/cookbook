import 'package:flutter/material.dart';
import 'package:hi365/pages/checkup/index.dart';

@immutable
class CheckupDownloadState {
  final bool isInsitutionValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isEmpty;
  List<CheckupInstitution> institutionList;

  CheckupDownloadState({
    @required this.isInsitutionValid,
    @required this.isSubmitting,
    @required this.isFailure,
    @required this.isSuccess,
    @required this.isEmpty,
    @required this.institutionList,
  });

  bool get isFormValid => isInsitutionValid;

  factory CheckupDownloadState.empty() {
    return CheckupDownloadState(
      isInsitutionValid: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
      isEmpty: true,
      institutionList: [],
    );
  }

  factory CheckupDownloadState.loading() {
    return CheckupDownloadState(
      isInsitutionValid: true,
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
      isEmpty: false,
      institutionList: [],
    );
  }

  factory CheckupDownloadState.failure() {
    return CheckupDownloadState(
      isInsitutionValid: true,
      isSubmitting: false,
      isFailure: true,
      isSuccess: false,
      isEmpty: false,
      institutionList: [],
    );
  }

  factory CheckupDownloadState.success() {
    return CheckupDownloadState(
      isInsitutionValid: true,
      isSubmitting: false,
      isFailure: false,
      isSuccess: true,
      isEmpty: false,
      institutionList: [],
    );
  }

  CheckupDownloadState update({
    bool isInsitutionValid,
    List<CheckupInstitution> institutionList,
  }) {
    return copyWith(
      isInsitutionValid: isInsitutionValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isEmpty: false,
      institutionList: institutionList,
    );
  }

  CheckupDownloadState copyWith({
    bool isInsitutionValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool isEmpty,
    List<CheckupInstitution> institutionList,
  }) {
    return CheckupDownloadState(
      isInsitutionValid: isInsitutionValid ?? this.isInsitutionValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isEmpty: isEmpty ?? this.isEmpty,
      institutionList: institutionList ?? this.institutionList,
    );
  }

  @override
  String toString() {
    return '''CheckupDownloadState {
      isInsitutionValid: $isInsitutionValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isEmpty:= $isEmpty,
      institutionList:= $institutionList,
    }
    ''';
  }
}
