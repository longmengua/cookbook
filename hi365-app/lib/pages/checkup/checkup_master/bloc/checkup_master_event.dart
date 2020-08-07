import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CheckupMasterEvent extends Equatable {}

class LoadCheckupMaster extends CheckupMasterEvent {
  @override
  String toString() => 'LoadCheckupMaster';

  @override
  List<Object> get props => null;
}

class CleanMaster extends CheckupMasterEvent {
  @override
  String toString() => 'CleanMaster';

  @override
  List<Object> get props => null;
}
