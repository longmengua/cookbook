import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hi365/pages/checkup/index.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';
import '../../checkup_repository.dart';

class CheckupDownloadBloc
    extends Bloc<CheckupDownloadEvent, CheckupDownloadState> {
  static final CheckupDownloadBloc _checkupDownloadBloc =
      CheckupDownloadBloc._internal();
  factory CheckupDownloadBloc() => _checkupDownloadBloc;
  CheckupDownloadBloc._internal();

  final CheckupRepository _checkupRepository = CheckupRepository();

  @override
  CheckupDownloadState get initialState => CheckupDownloadState.empty();

  @override
  Stream<CheckupDownloadState> transformEvents(
    Stream<CheckupDownloadEvent> events,
    Stream<CheckupDownloadState> Function(CheckupDownloadEvent event) next,
  ) {
    final observableStream = events as Observable<CheckupDownloadEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! InstitutionChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is InstitutionChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<CheckupDownloadState> mapEventToState(
    CheckupDownloadEvent event,
  ) async* {
    if (event is GetInstituionList) {
      yield* _mapGetInstitutionToState();
    } else if (event is ClearInputs) {
      yield CheckupDownloadState.empty();
    } else if (event is InstitutionChanged) {
      yield* _mapInstitutionChangedToState(event.institution);
    } else if (event is Submitted) {
      yield* _mapSubmittedToState(
        hospitalId: event.hospitalId,
      );
    }
  }

  Stream<CheckupDownloadState> _mapGetInstitutionToState() async* {
    List<CheckupInstitution> institutionList =
        await _checkupRepository.fetchInsitutions();
    yield state.update(institutionList: institutionList);
  }

  Stream<CheckupDownloadState> _mapInstitutionChangedToState(
    String institution,
  ) async* {
    yield state.update(
      isInsitutionValid: institution.isNotEmpty,
    );
  }

  Stream<CheckupDownloadState> _mapSubmittedToState({
    @required String hospitalId,
  }) async* {
    yield CheckupDownloadState.loading();
    try {
      await _checkupRepository.fetchHealthReport(hospitalId);
      yield CheckupDownloadState.success();
    } catch (_) {
      yield CheckupDownloadState.failure();
    }
  }
}
