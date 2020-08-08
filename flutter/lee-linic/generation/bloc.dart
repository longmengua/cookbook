import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class InterfaceBloc extends Bloc<InterfaceEvent, InterfaceState> {
  @override
  InterfaceState get initialState => InitState();

  @override
  Stream<InterfaceState> mapEventToState(InterfaceEvent e) async* {
    if (e is InitEvent) {
      ///todo: Implementation
      print(e);
    }
  }
}
