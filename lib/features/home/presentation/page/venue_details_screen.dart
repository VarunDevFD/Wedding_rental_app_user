import 'package:flutter/material.dart'; 
import 'package:vr_wedding_rental/features/home/domain/entities/venue.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/venue_details_widget.dart';

class VenueDetailsScreen extends StatelessWidget {
  final Venue venue;

  const VenueDetailsScreen({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(venue.name!),
      ),
      body: SingleChildScrollView(
        child: VenueDetailsWidget(venue: venue),
      ),
    );
  }
}