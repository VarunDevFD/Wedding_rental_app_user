import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vr_wedding_rental/features/home/domain/entities/venue.dart';

class VenueDetailsWidget extends StatelessWidget {
  final Venue venue;

  const VenueDetailsWidget({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Carousel
          venue.images!.isNotEmpty
              ? CarouselSlider(
                  options: CarouselOptions(
                    height: 250.0,
                    autoPlay: venue.images!.length > 1 ? true : false,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                  ),
                  items: venue.images!.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/placeholder.jpeg',
                                fit: BoxFit.cover,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              : Image.asset(
                  'assets/images/placeholder.jpeg',
                  height: 200.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          const SizedBox(height: 16.0),
          // Venue Name
          Text(
            venue.name!,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8.0),
          // Price
          Text(
            'Price: \$${venue.price}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            'Security Deposit: \$${venue.sdPrice}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8.0),
          // Location
          Text(
            'Location: ${venue.location!.join(", ")}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8.0),
          // Description
          Text(
            'Description: ${venue.description}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8.0),
          // Capacity
          Text(
            'Capacity: ${venue.capacity} guests',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          // Duration
          Text(
            'Duration: ${venue.duration}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          // Venue Type
          Text(
            'Venue Type: ${venue.venueType}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          // Phone Number
          Text(
            'Contact: ${venue.phoneNumber}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          // Date
          Text(
            'Available Date: ${venue.date}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8.0),
          // Facilities
          Text(
            'Facilities:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          ...venue.facilities!.map(
            (facility) => Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
              child: Text('• $facility'),
            ),
          ),
          const SizedBox(height: 8.0),
          // Availability
          Text(
            'Available: ${venue.available! ? "Yes" : "No"}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          // Privacy Policy
          Text(
            'Privacy Policy: ${venue.privacyPolicy! ? "Accepted" : "Not Accepted"}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
