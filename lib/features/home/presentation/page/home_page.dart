import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/animated_search_bar.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/carousel_widget.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/category_list.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/section_header.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/horizontal_grid_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
            const SectionHeader(title: 'Categories'),
            const CategoryListView(),
            const SectionHeader(title: 'Camera'),
            const VenueGridView(),
            const SectionHeader(title: 'Dress'),
            const VenueGridView(),
            const SectionHeader(title: 'Decoration'),
            const VenueGridView(),
            const SectionHeader(title: 'FootWear'),
            const VenueGridView(),
            const SectionHeader(title: 'Jewelry'),
            const VenueGridView(),
            const SectionHeader(title: 'Sound and Dj'),
            const VenueGridView(),
            const SectionHeader(title: 'Vehicle'),
            const VenueGridView(),
            const SectionHeader(title: 'Venue'),
            const VenueGridView(),

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
