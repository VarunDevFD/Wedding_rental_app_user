import 'package:dartz/dartz.dart';
import 'package:vr_wedding_rental/core/error/failure.dart';
import 'package:vr_wedding_rental/features/home/domain/entities/venue.dart';
import 'package:vr_wedding_rental/features/home/domain/repository/venue_repo_domain.dart';
 
class GetVenues {
final VenueRepository repository;

GetVenues(this.repository);

Future<Either<Failure, List<Venue>>> call() async {
return await repository.getAllVenues();
}
}