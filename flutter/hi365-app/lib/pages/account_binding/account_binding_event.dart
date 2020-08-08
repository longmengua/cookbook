import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AccountBindingEvent extends Equatable {
  AccountBindingEvent();
}

class AccountInfoNameChanged extends AccountBindingEvent {
  final String accountInfoName;

  AccountInfoNameChanged({
    @required this.accountInfoName,
  });

  @override
  String toString() =>
      'AccountInfoNameChanged { accountInfoName :$accountInfoName }';

  @override
  List<Object> get props => [accountInfoName];
}

class BirthdayChanged extends AccountBindingEvent {
  final String birthday;

  BirthdayChanged({@required this.birthday});

  @override
  String toString() => 'BirthdayChanged { password: $birthday }';

  @override
  List<Object> get props => [birthday];
}

class UsernameChanged extends AccountBindingEvent {
  final String username;

  UsernameChanged({@required this.username});

  @override
  String toString() => 'NameChanged { password: $username }';

  @override
  List<Object> get props => [username];
}

class OrganizationChanged extends AccountBindingEvent {
  final String organization;

  OrganizationChanged({@required this.organization});

  @override
  String toString() => 'OrganizationChanged { organization: $organization }';

  @override
  List<Object> get props => [organization];
}

class Submitted extends AccountBindingEvent {
  final String accountInfoName;
  final String birthday;
  final String username;
  final String organization;

  Submitted({
    @required this.accountInfoName,
    @required this.birthday,
    @required this.username,
    @required this.organization,
  });

  @override
  String toString() => '''
      Submitted {
        accountInfoName: $accountInfoName,
        birthday: $birthday,
        name: $username,
        organization:$organization,
      }''';

  @override
  List<Object> get props => [accountInfoName, birthday, username, organization];
}
