import 'package:bloc/bloc.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/features/home/domain/usecases/get_venues.dart';
import 'firebase_category_bloc_event.dart';
import 'firebase_category_bloc_state.dart';

class FirebaseCategoryBloc
    extends Bloc<FirebaseCategoryEvent, FirebaseCategoryState> {
  FirebaseCategoryBloc() : super(FirebaseCategoryBlocInitial()) {
    on<VenueCategoryEvent>(_onFetchVenues);
    add(VenueCategoryEvent());
  }

  void _onFetchVenues(
      VenueCategoryEvent event, Emitter<FirebaseCategoryState> emit) async {
    emit(FirestoreCategoryLoading());
    final getVenues = serviceLocator<GetVenues>();

    final result = await getVenues.read();

    result.fold(
      (failure) => emit(FirebaseCategoryError(message: failure.message)),
      (venues) => emit(FirebaseCategoryLoaded(venues)),
    );
  }
}
