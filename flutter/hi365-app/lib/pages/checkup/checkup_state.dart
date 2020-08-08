import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CheckupState extends Equatable {}

class UninitializedCheckup extends CheckupState {
  @override
  String toString() => 'UninitializedCheckup';

  @override
  List<Object> get props => null;
}

class InitializedCheckup extends CheckupState {
  @override
  String toString() => 'InitializedCheckup';

  @override
  List<Object> get props => null;
}

class LoadingCheckup extends CheckupState {
  @override
  String toString() => 'LoadingCheckup';

  @override
  List<Object> get props => null;
}

class NoCheckupData extends CheckupState {
  @override
  String toString() => 'NoCheckupData';

  @override
  List<Object> get props => null;
}

class IncompletePersonalInfo extends CheckupState {
  @override
  String toString() => 'IncompletePersonalInfo';

  @override
  List<Object> get props => null;
}

class CompletePersonalInfo extends CheckupState {
  @override
  String toString() => 'CompletePersonalInfo';

  @override
  List<Object> get props => null;
}

class ErrorCheckupState extends CheckupState {
  final String errorMessage;

  ErrorCheckupState(this.errorMessage);

  @override
  String toString() => 'ErrorCheckupState';

  @override
  List<Object> get props => [errorMessage];
}
