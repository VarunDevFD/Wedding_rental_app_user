import 'package:cloud_firestore/cloud_firestore.dart';

class VenueModel {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String country;
  final double latitude;
  final double longitude;

  VenueModel({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  factory VenueModel.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return VenueModel(
      id: snapshot.id,
      name: data['name'] as String,
      address: data['address'] as String,
      city: data['city'] as String,
      state: data['state'] as String,
      country: data['country'] as String,
      latitude: (data['latitude'] as num).toDouble(),
      longitude: (data['longitude'] as num).toDouble(),
    );
  }

  Future<List<dynamic>> toEntity() {
    return Future.value([
      id,
      name,
      address,
      city,
      state,
      country,
      latitude,
      longitude,
    ]);
  }
}
