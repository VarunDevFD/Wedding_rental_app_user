import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/venue.dart';

abstract class VenueRemoteDataSource {
  Future<List<Venue>> getAllVenues();
}

class VenueRemoteDataSourceImpl implements VenueRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<Venue>> getAllVenues() async {
    final snapshot = await firestore.collection('Venue').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Venue(
        id: doc.id,
        name: data['name'] as String,
        location: data['location'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        images: (data['images'] as List<dynamic>).cast<String>(),
      );
    }).toList();
  }
}
