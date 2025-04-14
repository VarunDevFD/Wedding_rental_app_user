import 'package:bloc/bloc.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/features/home/domain/usecase/venue_usecase.dart';

import 'venues_event.dart';
import 'venues_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(VenueInitial()) {
    on<FetchVenues>(_onFetchVenues);
  }

  Future<void> _onFetchVenues(
      FetchVenues event, Emitter<HomeState> emit) async {
    final getVenues = serviceLocator<GetVenues>();

    emit(VenueLoading());
    try {
      final venues = await getVenues();
      emit(VenueLoaded(venues));
    } catch (e) {
      emit(VenueError('Failed to load venues: ${e.toString()}'));
    }
  }
}
