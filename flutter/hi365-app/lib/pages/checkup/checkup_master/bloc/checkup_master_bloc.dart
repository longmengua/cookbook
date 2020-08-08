import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../checkup_model.dart';
import '../../checkup_repository.dart';
import './bloc.dart';

class CheckupMasterBloc extends Bloc<CheckupMasterEvent, CheckupMasterState> {
  final CheckupRepository _checkupRepository = CheckupRepository();

  @override
  CheckupMasterState get initialState => InitialCheckupMaster();

  @override
  Stream<CheckupMasterState> mapEventToState(
    CheckupMasterEvent event,
  ) async* {
    try {
      if (event is LoadCheckupMaster) {
        yield LoadingCheckupMaster();
        List<CheckupMaster> master = await _checkupRepository.fetchMaster();
        yield master.isNotEmpty
            ? InitializedCheckupMaster(master)
            : NoCheckupMasterData();
      } else if (event is CleanMaster) {
        yield InitialCheckupMaster();
      }
    } catch (exception, stackTrace) {
      yield ErrorCheckupMaster('$exception $stackTrace');
    }
  }
}
