import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CheckupEvent extends Equatable {}

class LoadCheckup extends CheckupEvent {
  @override
  String toString() => 'LoadCheckup';

  @override
  List<Object> get props => null;
}

class ShowNoDataPage extends CheckupEvent {
  @override
  String toString() => 'ShowNoDataPage';

  @override
  List<Object> get props => null;
}

class ShowLoadingSnackBar extends CheckupEvent {
  @override
  String toString() => 'ShowLoadingSnackBar';

  @override
  List<Object> get props => null;
}

class CheckPersonalInfo extends CheckupEvent {
  @override
  String toString() => 'CheckPersonalInfo';

  @override
  List<Object> get props => null;
}

class ErrorOccurEvent extends CheckupEvent {
  final String errorMessage;

  ErrorOccurEvent(this.errorMessage);

  @override
  String toString() => 'ErrorOccurEvent : $errorMessage';

  @override
  List<Object> get props => [errorMessage];
}
