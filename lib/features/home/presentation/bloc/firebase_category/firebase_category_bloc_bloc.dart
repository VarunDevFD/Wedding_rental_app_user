import 'package:bloc/bloc.dart';
import 'package:vr_wedding_rental/features/home/domain/usecases/get_venues.dart';
import 'firebase_category_bloc_event.dart';
import 'firebase_category_bloc_state.dart';

class FirebaseCategoryBloc
    extends Bloc<FirebaseCategoryEvent, FirebaseCategoryState> {
  final GetVenues getVenues;

  FirebaseCategoryBloc({required this.getVenues})
      : super(FirebaseCategoryBlocInitial()) {
    on<VenueCategoryEvent>(_onFetchVenues);
  }

  void _onFetchVenues(
      VenueCategoryEvent event, Emitter<FirebaseCategoryState> emit) async {
    emit(FirestoreCategoryLoading());
    final result = await getVenues();
    result.fold(
      (failure) => emit(FirebaseCategoryError(message: failure.message)),
      (venues) => emit(FirebaseCategoryLoaded(venues)),
    );
  }
}
