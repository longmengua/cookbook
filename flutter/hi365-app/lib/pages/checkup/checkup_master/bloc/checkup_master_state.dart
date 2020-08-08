import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../checkup_model.dart';

@immutable
abstract class CheckupMasterState extends Equatable {}

class InitialCheckupMaster extends CheckupMasterState {
  @override
  String toString() => 'InitialCheckupMaster';

  @override
  List<Object> get props => null;
}

class InitializedCheckupMaster extends CheckupMasterState {
  InitializedCheckupMaster(this.data);

  final List<CheckupMaster> data;

  @override
  String toString() => 'InitializedCheckupMaster';

  @override
  List<Object> get props => [data];
}

class NoCheckupMasterData extends CheckupMasterState {
  @override
  String toString() => 'NoCheckupMasterData';

  @override
  List<Object> get props => null;
}

class LoadingCheckupMaster extends CheckupMasterState {
  @override
  String toString() => 'LoadingCheckupMaster';

  @override
  List<Object> get props => null;
}

class ErrorCheckupMaster extends CheckupMasterState {
  final String errorMessage;

  ErrorCheckupMaster(this.errorMessage);

  @override
  String toString() => 'ErrorCheckupMaster';

  @override
  List<Object> get props => [errorMessage];
}
