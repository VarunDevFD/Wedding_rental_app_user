// Carousel Slides
import 'package:flutter/material.dart';

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
        fit:
            BoxFit.fitWidth, // Fill the container while preserving aspect ratio
        width: double.infinity, // Make the image fill the width
      ),
    ),
  ),
];
