import 'package:flutter/material.dart';
import 'package:hi365/pages/dashboard/index.dart';

// Template 1
@immutable
class DashboardState {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final LunarCalenderAdvices advices;

  DashboardState({
    @required this.isLoading,
    @required this.isFailure,
    @required this.isSuccess,
    this.advices,
  });

  factory DashboardState.empty() {
    return DashboardState(
      isLoading: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory DashboardState.loading() {
    return DashboardState(
      isLoading: true,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory DashboardState.failure() {
    return DashboardState(
      isLoading: false,
      isFailure: true,
      isSuccess: false,
    );
  }

  factory DashboardState.success() {
    return DashboardState(
      isLoading: false,
      isFailure: false,
      isSuccess: true,
    );
  }

  DashboardState update({
    LunarCalenderAdvices advices,
  }) {
    return copyWith(
      advices: advices,
      isLoading: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  DashboardState copyWith({
    LunarCalenderAdvices advices,
    bool isLoading,
    bool isSuccess,
    bool isFailure,
  }) {
    return DashboardState(
      advices: advices ?? this.advices,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''DashboardState {
      advices: $advices,
      isLoading: $isLoading,
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
// abstract class DashboardState extends Equatable {
//   DashboardState([List props = const <dynamic>[]]) : super(props);
// }
//
// class InitialDashboard extends DashboardState {
//   @override
//   String toString() => 'InitialDashboard';
// }
//
// class LoadingDashboard extends DashboardState {
//   @override
//   String toString() => 'LoadingDashboard';
// }
//
// class InitializedDashboard extends DashboardState {
//   @override
//   String toString() => 'InitializedDashboard';
// }
//
// class ErrorDashboard extends DashboardState {
//   ErrorDashboard({this.errorMessage});
//
//   final String errorMessage;
//
//   @override
//   String toString() => 'ErrorDashboard : $errorMessage';
// }
