import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vr_wedding_rental/features/home/data/model/venue_model.dart'; 

abstract class VenueRemoteDataSource {
  Future<List<VenueModel>> getVenues();

}

class VenueRemoteDataSourceImpl implements VenueRemoteDataSource {
  final FirebaseFirestore firestore;

  VenueRemoteDataSourceImpl(this.firestore);

  // Function to fetch data from Firestore
  Future<List<T>> fetchFromFirestoore<T>({
    required String collectionName,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      final snapshot =
          await firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) => fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to fetch data from $collectionName: $e');
    }
  }



  @override
  Future<List<VenueModel>> getVenues() async {
    return await fetchFromFirestoore<VenueModel>(
      collectionName: 'venues',
      fromMap: (data) => VenueModel.fromMap(data),
    );
  }
}