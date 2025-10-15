import 'package:flutter/material.dart';

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
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.foregroundColor,
  });
}
