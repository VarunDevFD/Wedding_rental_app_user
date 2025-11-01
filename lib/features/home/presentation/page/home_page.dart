import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/animated_search_bar.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/carousel_widget.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/category_list.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/popular_grid_list.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/section_header.dart';

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
            const SectionHeader(title: 'Categories'),
            const CategoryListView(),

            Row(
              children: [
                const SectionHeader(title: 'Popular Items'),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    log('See All tapped');
                    context.go('/popularScreen');
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const PopularModelGridView(),

            // const SectionHeader(title: 'Venue'),
            // const VenueGridView(),

            const SizedBox(height: 20), // Space between sections
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
