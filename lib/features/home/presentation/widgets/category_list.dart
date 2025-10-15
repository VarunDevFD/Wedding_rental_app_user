import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/features/home/data/model/category_list_model.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      CategoryListModel('a',
          label: "Camera",
          icon: Icons.photo_camera,
          width: 160,
          height: 70,
          backgroundColor: AppColors.categoryListModelBGcolor,
          foregroundColor: Colors.purple.shade300),
      CategoryListModel('b',
          label: "Dress",
          icon: Icons.checkroom,
          width: 160,
          height: 70,
          backgroundColor: AppColors.categoryListModelBGcolor,
          foregroundColor: Colors.purple.shade300),
      CategoryListModel('c',
          label: "Decoration",
          icon: Icons.event,
          width: 160,
          height: 70,
          backgroundColor: AppColors.categoryListModelBGcolor,
          foregroundColor: Colors.purple.shade300),
      CategoryListModel('d',
          label: "FootWear",
          icon: Icons.directions_walk,
          width: 160,
          height: 70,
          backgroundColor: AppColors.categoryListModelBGcolor,
          foregroundColor: Colors.purple.shade300),
      CategoryListModel('e',
          label: "Jewelry",
          icon: Icons.watch,
          width: 160,
          height: 70,
          backgroundColor: AppColors.categoryListModelBGcolor,
          foregroundColor: Colors.purple.shade300),
      CategoryListModel('f',
          label: "Sound & Dj",
          icon: Icons.music_note,
          width: 160,
          height: 70,
          backgroundColor: AppColors.categoryListModelBGcolor,
          foregroundColor: Colors.purple.shade300),
      CategoryListModel('g',
          label: "Vehicle",
          icon: Icons.directions_car,
          width: 160,
          height: 70,
          backgroundColor: AppColors.categoryListModelBGcolor,
          foregroundColor: Colors.purple.shade300),
      CategoryListModel('h',
          label: "Venue",
          icon: Icons.location_city,
          width: 160,
          height: 70,
          backgroundColor: AppColors.categoryListModelBGcolor,
          foregroundColor: Colors.purple.shade300),
    ];

    final firstRow = <CategoryListModel>[];
    final secondRow = <CategoryListModel>[];
    for (int i = 0; i < categories.length; i++) {
      if (i % 2 == 0) {
        firstRow.add(categories[i]);
      } else {
        secondRow.add(categories[i]);
      }
    }

    return SizedBox(
      height: 180,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(firstRow.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  buildCategoryItem(firstRow[index]),
                  const SizedBox(height: 20),
                  if (index < secondRow.length)
                    buildCategoryItem(secondRow[index]),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildCategoryItem(CategoryListModel category) {
    return Container(
      width: category.width,
      height: category.height,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: category.backgroundColor,
        borderRadius: BorderRadius.circular(33),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: category.foregroundColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              category.icon ?? Icons.category,
              color: Colors.white,
              size: 30,
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
      ),
    );
  }
}
