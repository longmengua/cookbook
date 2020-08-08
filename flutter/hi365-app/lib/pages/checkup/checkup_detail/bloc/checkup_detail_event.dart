import 'package:equatable/equatable.dart';
import 'package:hi365/pages/checkup/checkup_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CheckupDetailEvent extends Equatable {}

class LoadDetail extends CheckupDetailEvent {
  final String reportId;
  final CheckupMaster data;

  LoadDetail(this.reportId, this.data);

  @override
  String toString() => 'LoadDetailEvent';

  @override
  List<Object> get props => [reportId];
}

class CleanDeatail extends CheckupDetailEvent {
  @override
  String toString() => 'CleanDeatail';

  @override
  List<Object> get props => null;
}
