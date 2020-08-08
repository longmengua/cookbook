import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class DashboardEvent extends Equatable {}

class InitialDashboard extends DashboardEvent {
  @override
  String toString() => 'InitialDashboardEvent';

  @override
  List<Object> get props => null;
}

class InitializedDashboard extends DashboardEvent {
  @override
  String toString() => 'InitializedDashboardEvent';

  @override
  List<Object> get props => null;
}
