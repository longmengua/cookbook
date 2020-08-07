import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hi365/pages/account_binding/index.dart';
import 'package:hi365/utils/api_response.dart';

class AccountBindingBloc
    extends Bloc<AccountBindingEvent, AccountBindingState> {
  static final AccountBindingBloc _accountBindingBlocSingleton =
      AccountBindingBloc._internal();
  factory AccountBindingBloc() => _accountBindingBlocSingleton;
  AccountBindingBloc._internal();

  final AccountBindingRepository _accountBindingRepository =
      AccountBindingRepository();

  AccountBindingState get initialState => AccountBindingState.empty();

  @override
  Stream<AccountBindingState> mapEventToState(
    AccountBindingEvent event,
  ) async* {
    if (event is AccountInfoNameChanged) {
      yield* _mapAccountInfoNameCangedToState(event.accountInfoName);
    } else if (event is BirthdayChanged) {
      yield* _mapBirthdayChangedToState(event.birthday);
    } else if (event is UsernameChanged) {
      yield* _mapNameChangedToState(event.username);
    } else if (event is OrganizationChanged) {
      yield* _mapOrganizationChangedToState(event.organization);
    } else if (event is Submitted) {
      yield* _mapSubmittedToState(
        event.accountInfoName,
        event.birthday,
        event.username,
        event.organization,
      );
    }
  }

  Stream<AccountBindingState> _mapAccountInfoNameCangedToState(
    String accountInfoName,
  ) async* {
    yield state.update(
      isAccountInfoNameValid: accountInfoName.isNotEmpty,
    );
  }

  Stream<AccountBindingState> _mapBirthdayChangedToState(
    String birthday,
  ) async* {
    yield state.update(
      isBirthdayValid: birthday.isNotEmpty,
    );
  }

  Stream<AccountBindingState> _mapNameChangedToState(
    String username,
  ) async* {
    yield state.update(
      isUsernameValid: username.isNotEmpty,
    );
  }

  Stream<AccountBindingState> _mapOrganizationChangedToState(
    String organization,
  ) async* {
    yield state.update(
      isOrganizationValid: organization.isNotEmpty,
    );
  }

  Stream<AccountBindingState> _mapSubmittedToState(
    String accountInfoName,
    String birthday,
    String name,
    String organization,
  ) async* {
    try {
      BindingInfo bindingInfo = BindingInfo();
      bindingInfo.accountInfoName = accountInfoName;
      bindingInfo.birthday =
          DateTime.parse(birthday.split('/').join('-')).millisecondsSinceEpoch;
      yield AccountBindingState.loading();
      ApiResponse res = await _accountBindingRepository.push(bindingInfo);
      if (res.success) {
        yield AccountBindingState.success();
      } else {
        throw Exception(res.message);
      }
    } catch (e) {
      yield AccountBindingState.failure(e.message);
    }
  }
}
