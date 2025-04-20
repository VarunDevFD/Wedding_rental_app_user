import 'package:vr_wedding_rental/features/home/domain/entities/venue.dart';

abstract class FirebaseCategoryState {}

final class FirebaseCategoryBlocInitial extends FirebaseCategoryState {}

class FirestoreCategoryLoading extends FirebaseCategoryState {}

class FirebaseCategoryLoaded extends FirebaseCategoryState {
  final List<Venue> venues;

  FirebaseCategoryLoaded(this.venues);
}

class FirebaseCategoryError extends FirebaseCategoryState {
  final String message;

  FirebaseCategoryError({required this.message});
}
