import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/core/utils/helper/image_concatinate.dart';
import 'package:vr_wedding_rental/features/home/data/model/venue_model.dart';

abstract class VenueRemoteDataSource {
  Future<List<VenueModel>> getAllVenues();
}

class VenueRemoteDataSourceImpl implements VenueRemoteDataSource {
  final firestore = serviceLocator<FirebaseFirestore>();

  @override
  Future<List<VenueModel>> getAllVenues() async {
    try {
      final QuerySnapshot snapshot = await firestore.collection('venues').get();
      if (snapshot.docs.isEmpty) {
        // log('No venues found');
        return [];
      }

      final venues = <VenueModel>[];
      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final images = List<String>.from(data['images'] ?? []);

        List<String> processedImages = images;
        if (images.isNotEmpty) {
          try {
            processedImages = ImageConcatinate.concatinateImage(images);
          } catch (e) {
            // Fallback to original images if processing fails
            processedImages = images;
          }
        }
        //  else {
        //   log('No images found for venue ${doc.id}');
        // }

        // Create updated data map with processed images
        final updatedData = {
          ...data,
          'images': processedImages,
        };

        // Convert to VenueModel
        venues.add(VenueModel.fromMap(updatedData));
      }

      return venues;
    } catch (e) {
      rethrow;
    }
  }
}
