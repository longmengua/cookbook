import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import 'index.dart';

abstract class PersonalInfoEvent extends Equatable {}

class UsernameChanged extends PersonalInfoEvent {
  final String username;

  UsernameChanged({@required this.username});

  @override
  String toString() => 'UsernameChanged { username: $username }';

  @override
  List<Object> get props => [username];
}

class GenderChanged extends PersonalInfoEvent {
  final String gender;

  GenderChanged({@required this.gender});

  @override
  String toString() => 'GenderChanged { gender: $gender }';

  @override
  List<Object> get props => [gender];
}

class IDNumberChanged extends PersonalInfoEvent {
  final String idNumber;

  IDNumberChanged({@required this.idNumber});

  @override
  List<Object> get props => [idNumber];

  @override
  String toString() => 'IDNumberChanged { id number: $idNumber }';
}

class BirthdayChanged extends PersonalInfoEvent {
  final String birthday;

  BirthdayChanged({@required this.birthday});

  @override
  String toString() => 'BirthdayChanged { birthday: $birthday }';

  @override
  List<Object> get props => [birthday];
}

class Submitted extends PersonalInfoEvent {
  final PersonalInfo personalInfo;

  Submitted({
    @required this.personalInfo,
  });

  @override
  String toString() => 'Submitted { personalInfo: ${personalInfo.toString()},';

  @override
  List<Object> get props => [personalInfo];
}
