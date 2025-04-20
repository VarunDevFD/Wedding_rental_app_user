import 'package:dartz/dartz.dart';
import 'package:vr_wedding_rental/core/error/failure.dart';
import 'package:vr_wedding_rental/features/home/domain/entities/venue.dart';

abstract class VenueRepository {
Future<Either<Failure, List<Venue>>> getAllVenues();
}