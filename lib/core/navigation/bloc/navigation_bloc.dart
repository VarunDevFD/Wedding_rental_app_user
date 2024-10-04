import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';


class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial(0)) {
    on<TabChange>((event, emit) {
      emit(NavigationUpdated(event.tabIndex)); // Update the state with the new index
    });
  }
}
