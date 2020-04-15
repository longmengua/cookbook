import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hi365/pages/home/index.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_model.dart';
import 'package:hi365/pages/other_setting/personalInfo/personal_provider.dart';

enum HomeEvent {
  init,
  dashboard,
  signPrivacyPolicy,
}

enum HomeState {
  init,
  dashboard,
  personal,
  signPolicy,
  error,
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static final HomeBloc _homeBlocSingleton = HomeBloc._internal();

  factory HomeBloc() => _homeBlocSingleton;

  HomeBloc._internal();

  final PersonalProvider _personalProvider = PersonalProvider();
  PersonalModel personalModel;
  bool didSignPrivacyPolicy;
  String privacyPolicyPaper;

  HomeState get initialState => HomeState.init;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    try {
      switch (event) {
        case HomeEvent.signPrivacyPolicy:
          _personalProvider.signingPrivacyPolicy();
          didSignPrivacyPolicy = true;
          personalModel = await _personalProvider.getPersonalInfo();
          yield validatePersonalInfo(personalModel)
              ? HomeState.dashboard
              : HomeState.personal;
          break;
        case HomeEvent.dashboard:
          if (didSignPrivacyPolicy == null) {
            final bool = await _personalProvider.didSignPrivacyPolicy();
            didSignPrivacyPolicy = bool == null ? null : bool == 'true';
          }
          if (didSignPrivacyPolicy) {
            personalModel = await _personalProvider.getPersonalInfo();
            yield validatePersonalInfo(personalModel)
                ? HomeState.dashboard
                : HomeState.personal;
            break;
          }
          privacyPolicyPaper = await _personalProvider.privacyPolicyPaper();
          yield HomeState.signPolicy;
          break;
        case HomeEvent.init:
          didSignPrivacyPolicy = null;
          personalModel = null;
          yield HomeState.init;
          break;
      }
    } catch (_, stackTrace) {
      yield HomeState.error;
      print('$_ $stackTrace');
    }
  }

  void dispose(filename) {
    _homeBlocSingleton.close();
  }

  bool validatePersonalInfo(PersonalModel personalModel) {
    return personalModel?.name != null &&
        personalModel?.gender != null &&
        personalModel?.birthday != null;
  }
}
