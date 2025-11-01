import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/features/home/data/model/category_list_model.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      CategoryListModel('a', label: "Camera", icon: Icons.photo_camera),
      CategoryListModel('b', label: "Dress", icon: Icons.checkroom),
      CategoryListModel('c', label: "Decoration", icon: Icons.event),
      CategoryListModel('d', label: "FootWear", icon: Icons.directions_walk),
      CategoryListModel('e', label: "Jewelry", icon: Icons.watch),
      CategoryListModel('f', label: "Sound & Dj", icon: Icons.music_note),
      CategoryListModel('g', label: "Vehicle", icon: Icons.directions_car),
      CategoryListModel('h', label: "Venue", icon: Icons.location_city),
    ];

    return SizedBox(
      height: 100, // adjust based on your category height
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(categories.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  // Handle category tap
                  log('Tapped on category: ${categories[index].label}');
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      buildCategoryItem(categories[index]),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildCategoryItem(CategoryListModel category) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(126, 255, 255, 255), // ~0.25 opacity white
                    Color.fromARGB(42, 255, 255, 255), // ~0.05 opacity white
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: const Color.fromARGB(
                      145, 255, 255, 255), // ~0.3 opacity white
                  width: 1.2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(
                        60, 158, 158, 158), // subtle black shadow
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Icon(
                category.icon ?? Icons.category,
                color: AppColors.buttonTextColor,
                size: 28,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Center(
          child: Text(
            category.label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        )
      ],
    );
  }
}
