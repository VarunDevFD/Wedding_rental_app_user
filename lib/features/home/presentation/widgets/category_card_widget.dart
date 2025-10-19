import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/category_card_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryCardModel category;
  final double height;
  final double width;

  const CategoryCard({
    super.key,
    required this.category,
    this.height = 60,
    this.width = 120,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, category.route);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background image with error handling
            Positioned.fill(
              child: Image.asset(
                category.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image_not_supported,
                        color: Colors.grey, size: 40),
                  );
                },
              ),
            ),

            // Subtle dark overlay for better text contrast
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.35),
              ),
            ),

            // Category name text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      offset: Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
