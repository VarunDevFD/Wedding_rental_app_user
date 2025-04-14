 
import 'package:vr_wedding_rental/features/home/domain/models/entities/venue.dart';
import 'package:vr_wedding_rental/features/home/domain/repositories/venue_repository.dart';

class GetVenues {
  final VenueRepository repository;

  GetVenues(this.repository);

  Future<List<Venue>> call() async {
    return await repository.getVenues();
  }
}

 