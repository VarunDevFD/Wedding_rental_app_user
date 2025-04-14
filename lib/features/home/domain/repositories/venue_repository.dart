import 'package:vr_wedding_rental/features/home/domain/models/entities/venue.dart';

abstract class VenueRepository {
  Future<List<Venue>> getVenues();
}

