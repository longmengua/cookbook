import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:hi365/pages/personal_info/index.dart';
import 'index.dart';

class CheckupBloc extends Bloc<CheckupEvent, CheckupState> {
  static final CheckupBloc _checkupBlocSingleton = CheckupBloc._internal();

  factory CheckupBloc() => _checkupBlocSingleton;

  CheckupBloc._internal();

  PersonalInfo personalInfo;

  CheckupState get initialState => UninitializedCheckup();

  PersonalInfoRepository _personalInfoRepository = PersonalInfoRepository();

  @override
  Stream<CheckupState> mapEventToState(
    CheckupEvent event,
  ) async* {
    if (event is LoadCheckup) {
      yield InitializedCheckup();
    } else if (event is ShowNoDataPage) {
      yield NoCheckupData();
    } else if (event is ShowLoadingSnackBar) {
      yield LoadingCheckup();
    } else if (event is CheckPersonalInfo) {
      yield* _mapCheckPersonalInfoToState();
    } else if (event is ErrorOccurEvent) {
      yield ErrorCheckupState(event.errorMessage);
      yield NoCheckupData();
    }
  }

  Stream<CheckupState> _mapCheckPersonalInfoToState() async* {
    yield LoadingCheckup();
    try {
      ///Checking the personal information, which checkup need, is filled into database.
      personalInfo = await _personalInfoRepository.fetch();
      yield personalInfo.isValid
          ? CompletePersonalInfo()
          : IncompletePersonalInfo();
    } catch (e) {
      yield ErrorCheckupState(e);
    }
  }

  closeBloc() => _checkupBlocSingleton.close();
}
