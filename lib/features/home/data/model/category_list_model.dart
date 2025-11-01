import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';

class CategoryListModel {
  final String image;
  final String? label;
  final IconData? icon;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;

  CategoryListModel(
    this.image, {
    required this.label,
    required this.icon,
    this.width = 160,
    this.height = 70,
    this.backgroundColor = AppColors.categoryListModelBGcolor,
    this.foregroundColor = AppColors.buttonTextColor,
  });
}
