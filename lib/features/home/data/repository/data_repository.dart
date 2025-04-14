import 'package:vr_wedding_rental/features/home/data/data_source/data_source.dart';
import 'package:vr_wedding_rental/features/home/domain/models/entities/venue.dart';
import 'package:vr_wedding_rental/features/home/domain/repositories/venue_repository.dart';

class VenueRepositoryImpl implements VenueRepository {
  final VenueRemoteDataSource remoteDataSource;

  VenueRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Venue>> getVenues() async {
    try {
      final venueModels = await remoteDataSource.getVenues();
      return venueModels.map((model) => model.toEntity()).toList();
    } catch (e) {
     throw Exception('Failed to fetch venues: $e');
    }
  }
}
// class VenueRepositoryImpl implements VenueRepository {
//   final VenueRemoteDataSource remoteDataSource;

//   VenueRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<List<Venue>> getVenues() async {
//     try {
//       final venueModels = await remoteDataSource.getVenues();
//       return venueModels.map((model) => model.toEntity()).toList();
//     } catch (e) {
      
//     }
//   }
// }

  