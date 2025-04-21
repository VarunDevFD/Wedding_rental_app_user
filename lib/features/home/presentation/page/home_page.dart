import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/animated_search_bar.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/carousel_widget.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/section_header.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/horizontal_grid_view.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnimatedSearchBar(),
            CarouselWidget(carouselItems: carouselItems),
            const SectionHeader(title: 'Venues'),
            const VenueGridView(), // Popular items

            const SizedBox(height: 20), // Space between sections

            const SectionHeader(title: 'Recently'),
            // const GridView(), // Recently added items
          ],
        ),
      ),
    ));
  }

  // Carousel Slides
  final carouselItems = [
    Container(
      color: const Color.fromARGB(255, 171, 171, 171),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
        child: Image.asset(
          'assets/images/wedding_venues.jpg',
          fit: BoxFit.fill, // Fill the container while preserving aspect ratio
          width: double.infinity, // Make the image fill the width
        ),
      ),
    ),
    Container(
      color: const Color.fromARGB(255, 171, 171, 171),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
        child: Image.asset(
          'assets/images/wedding_jewllery.jpg',
          fit: BoxFit.fill, // Fill the container while preserving aspect ratio
          width: double.infinity, // Make the image fill the width
        ),
      ),
    ),
    Container(
      color: const Color.fromARGB(255, 171, 171, 171),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
        child: Image.asset(
          'assets/images/wedding_shoot.jpg',
          fit: BoxFit.fill, // Fill the container while preserving aspect ratio
          width: double.infinity, // Make the image fill the width
        ),
      ),
    ),
    Container(
      color: const Color.fromARGB(255, 171, 171, 171),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
        child: Image.asset(
          'assets/images/wedding_dress.jpg',
          fit: BoxFit
              .fitWidth, // Fill the container while preserving aspect ratio
          width: double.infinity, // Make the image fill the width
        ),
      ),
    ),
  ];
}
