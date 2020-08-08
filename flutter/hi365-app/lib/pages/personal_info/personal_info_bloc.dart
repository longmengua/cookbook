import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hi365/pages/personal_info/index.dart';
import 'package:rxdart/rxdart.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  static final PersonalInfoBloc _personalInfoBlocSingleton =
      PersonalInfoBloc._internal();
  factory PersonalInfoBloc() {
    return _personalInfoBlocSingleton;
  }
  PersonalInfoBloc._internal();

  final PersonalInfoRepository _personalInfoRepository =
      PersonalInfoRepository();

  PersonalInfoState get initialState => PersonalInfoState.empty();

  @override
  Stream<PersonalInfoState> transformEvents(
    Stream<PersonalInfoEvent> events,
    Stream<PersonalInfoState> Function(PersonalInfoEvent event) next,
  ) {
    final observableStream = events as Observable<PersonalInfoEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! GenderChanged &&
          event is! IDNumberChanged &&
          event is! UsernameChanged &&
          event is! BirthdayChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is GenderChanged ||
          event is IDNumberChanged ||
          event is UsernameChanged ||
          event is BirthdayChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<PersonalInfoState> mapEventToState(
    PersonalInfoEvent event,
  ) async* {
    if (event is UsernameChanged) {
      yield* _mapUsernameChangedToState(event.username);
    } else if (event is GenderChanged) {
      yield* _mapGenderChangedToState(event.gender);
    } else if (event is IDNumberChanged) {
      yield* _mapIDNumberChangedToState(event.idNumber);
    } else if (event is BirthdayChanged) {
      yield* _mapBirthdayChangedToState(event.birthday);
    } else if (event is Submitted) {
      yield* _mapGSubmittedToState(event.personalInfo);
    }
  }

  Stream<PersonalInfoState> _mapUsernameChangedToState(
    String usernmae,
  ) async* {
    yield state.update(
      isUsernameValid: usernmae.isNotEmpty,
    );
  }

  Stream<PersonalInfoState> _mapGenderChangedToState(
    String gender,
  ) async* {
    yield state.update(
      isGenderValid: gender.isNotEmpty,
    );
  }

  Stream<PersonalInfoState> _mapIDNumberChangedToState(
    String idNumber,
  ) async* {
    yield state.update(
      isIDNumberValid: idNumber.isNotEmpty,
    );
  }

  Stream<PersonalInfoState> _mapBirthdayChangedToState(
    String birthday,
  ) async* {
    yield state.update(
      isBirthdayValid: birthday.isNotEmpty,
    );
  }

  Stream<PersonalInfoState> _mapGSubmittedToState(
    PersonalInfo personalInfo,
  ) async* {
    yield PersonalInfoState.loading();
    try {
      await _personalInfoRepository.update(personalInfo);
      yield PersonalInfoState.success();
    } catch (e) {
      yield PersonalInfoState.failure();
    }
  }
}
