import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hi365/pages/dashboard/index.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  static final DashboardBloc _dashboardBlocSingleton =
      DashboardBloc._internal();
  factory DashboardBloc() => _dashboardBlocSingleton;
  DashboardBloc._internal();

  final DashboardRepository _dashboardRepository = DashboardRepository();

  DashboardState get initialState => DashboardState.empty();

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is InitialDashboard) {
      yield DashboardState.loading();
      LunarCalenderAdvices advices = await _dashboardRepository.fetchAdvices();
      yield DashboardState.success();
      yield* _mapInitialToState(advices);
    } else if (event is InitializedDashboard) {
      yield* _mapInitializedToState();
    }
  }

  Stream<DashboardState> _mapInitialToState(
    LunarCalenderAdvices advices,
  ) async* {
    yield state.update(advices: advices);
  }

  Stream<DashboardState> _mapInitializedToState() async* {
    // TODO: Change to the correct state
    yield DashboardState.empty();
  }
}
