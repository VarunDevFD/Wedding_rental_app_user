import 'package:dartz/dartz.dart';
import 'package:vr_wedding_rental/core/error/failure.dart';
import 'package:vr_wedding_rental/features/home/data/datasources/venue_remote_data_source.dart';
import 'package:vr_wedding_rental/features/home/domain/entities/venue.dart';
import 'package:vr_wedding_rental/features/home/domain/repository/venue_repo_domain.dart';

class VenueRepositoryImpl implements VenueRepository {
  final VenueRemoteDataSource remoteDataSource;

  VenueRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Venue>>> getAllVenues() async {
    try {
      final venueModels = await remoteDataSource.getAllVenues();
      final venues = venueModels
          .map((venueModel) => Venue(
                name: venueModel.name,
                price: venueModel.price,
                sdPrice: venueModel.sdPrice,
                location: venueModel.location,
                images: venueModel.images,
                description: venueModel.description,
                capacity: venueModel.capacity,
                duration: venueModel.duration,
                venueType: venueModel.venueType,
                phoneNumber: venueModel.phoneNumber,
                date: venueModel.date,
                facilities: venueModel.facilities,
                available: venueModel.available,
                privacyPolicy: venueModel.privacyPolicy,
              ))
          .toList();
      return Right(venues);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to fetch venues: $e'));
    }
  }
}
