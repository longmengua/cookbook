import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../index.dart';
import './bloc.dart';

class CheckupDetailBloc extends Bloc<CheckupDetailEvent, CheckupDetailState> {
  final CheckupRepository _checkupRepository = CheckupRepository();
  Map<String, List<CheckupDetail>> checkupDatailList = {};

  @override
  CheckupDetailState get initialState => InitialCheckupDetail();

  @override
  Stream<CheckupDetailState> mapEventToState(
    CheckupDetailEvent event,
  ) async* {
    try {
      if (event is LoadDetail) {
        yield* _mapLoadDetailToState(event.reportId, event.data);
      } else if (event is CleanDeatail) {
        yield* _mapCleanDeatailToState();
      }
    } catch (exception, stackTrace) {
      yield ErrorCheckupDetail('$exception $stackTrace');
    }
  }

  Stream<CheckupDetailState> _mapLoadDetailToState(String reportId, CheckupMaster data) async* {
    if (checkupDatailList.containsKey(reportId)) {
      yield InitializedCheckupDetail(checkupDatailList[reportId], data);
    } else {
      yield LoadingCheckupDetail();
      List<CheckupDetail> detail =
          await _checkupRepository.fetchDetail(reportId);
      checkupDatailList[reportId] = detail;
      yield detail.isNotEmpty
          ? InitializedCheckupDetail(detail, data)
          : NoCheckupDetailData();
    }
  }

  Stream<CheckupDetailState> _mapCleanDeatailToState() async* {
    checkupDatailList.clear();
    yield InitialCheckupDetail();
  }
}
