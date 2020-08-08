import 'package:equatable/equatable.dart';
import 'package:hi365/pages/checkup/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CheckupDetailState extends Equatable {}

class InitialCheckupDetail extends CheckupDetailState {
  @override
  String toString() => 'InitialCheckupDetail';

  @override
  List<Object> get props => null;
}

class LoadingCheckupDetail extends CheckupDetailState {
  @override
  String toString() => 'LoadingCheckupDetail';

  @override
  List<Object> get props => null;
}

class InitializedCheckupDetail extends CheckupDetailState {
  final List<CheckupDetail> data;
  final CheckupMaster advice;

  InitializedCheckupDetail(this.data, this.advice);

  @override
  String toString() => 'InitializedCheckupDetail';

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //         super == other &&
  //             other is InitializedCheckupDetail &&
  //             runtimeType == other.runtimeType &&
  //             data == other.data;

  // @override
  // int get hashCode => super.hashCode ^ data.hashCode;

  @override
  List<Object> get props => [data];
}

class NoCheckupDetailData extends CheckupDetailState {
  @override
  String toString() => 'NoCheckupDetailData';

  @override
  List<Object> get props => null;
}

class ErrorCheckupDetail extends CheckupDetailState {
  final String errorMessage;

  ErrorCheckupDetail(this.errorMessage);

  @override
  String toString() => 'ErrorCheckupDetail';

  @override
  List<Object> get props => [errorMessage];
}
