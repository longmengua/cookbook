import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class RegisterEvent extends Equatable {}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({
    @required this.email,
  });

  @override
  String toString() => 'EmailChanged { email :$email }';

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({
    @required this.password,
  });

  @override
  String toString() => 'PasswordChanged { password: $password }';

  @override
  List<Object> get props => [password];
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;

  Submitted({
    @required this.email,
    @required this.password,
  });

  @override
  String toString() => 'Submitted { email: $email, password: $password }';

  @override
  List<Object> get props => [email, password];
}
