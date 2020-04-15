import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CheckupDownloadEvent extends Equatable {}

class GetInstituionList extends CheckupDownloadEvent {
  @override
  String toString() => 'GetInstituionList';

  @override
  List<Object> get props => null;
}

class InstitutionChanged extends CheckupDownloadEvent {
  final String institution;

  InstitutionChanged({
    @required this.institution,
  });

  @override
  String toString() => 'InstitutionChanged { institution :$institution }';

  @override
  List<Object> get props => [institution];
}

class IDNumberChanged extends CheckupDownloadEvent {
  final String idNumber;

  IDNumberChanged({
    @required this.idNumber,
  });

  @override
  String toString() => 'IDNumberChanged { id number: $idNumber }';

  @override
  List<Object> get props => [idNumber];
}

class UsernameChanged extends CheckupDownloadEvent {
  final String username;

  UsernameChanged({
    @required this.username,
  });

  @override
  String toString() => 'UsernameChanged { username: $username }';

  @override
  List<Object> get props => [username];
}

class BirthdayChanged extends CheckupDownloadEvent {
  final String birthday;

  BirthdayChanged({
    @required this.birthday,
  });

  @override
  String toString() => 'BirthdayChanged { birthday: $birthday }';

  @override
  List<Object> get props => [birthday];
}

class Submitted extends CheckupDownloadEvent {
  final String hospitalId;

  Submitted({
    @required this.hospitalId,
  });

  @override
  String toString() => 'Submitted { institution: $hospitalId';

  @override
  List<Object> get props => [hospitalId];
}

class ClearInputs extends CheckupDownloadEvent {
  @override
  String toString() => 'ClearInputs';

  @override
  List<Object> get props => null;
}
