import 'package:vr_wedding_rental/features/home/domain/models/entities/venue.dart';

abstract class HomeState {}

class VenueInitial extends HomeState {}

class VenueLoading extends HomeState {}

class VenueLoaded extends HomeState {
  final List<Venue> venues;

  VenueLoaded(this.venues);
}

class VenueError extends HomeState {
  final String message;

  VenueError(this.message);
}
