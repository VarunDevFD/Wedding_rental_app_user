import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/popular_items_list_card_widget.dart';

class PopularItemsScreen extends StatelessWidget {
  const PopularItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');
          },
        ),
        title: const Text('Popular Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: ListView.builder(
          itemCount: popularItems.length,
          itemBuilder: (context, index) {
            final item = popularItems[index];
            return PopularItemsScreenData(item: item);
          },
        ),
      ),
    );
  }
}



// Example data model for popular items
class PopularItem {
  final String name;
  final String location;
  final double price;
  final double rating;
  final String imageUrl;
  final IconData? icon;

  PopularItem({
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.icon,
  });
}

final List<PopularItem> popularItems = [
  PopularItem(
    name: 'Elegant Wedding Dress',
    location: 'Malabar, Kerala',
    price: 299.0,
    rating: 4.8,
    imageUrl: 'assets/images/home_img.jpg',
    icon: Icons.shopping_bag_outlined,
  ),
  PopularItem(
    name: 'Luxury Wedding Venue',
    location: 'Goa, India',
    price: 999.0,
    rating: 4.9,
    imageUrl: 'assets/images/home_img.jpg',
    icon: Icons.agriculture,
  ),
  PopularItem(
    name: 'Diamond Ring Set',
    location: 'Mumbai, India',
    price: 499.0,
    rating: 4.7,
    imageUrl: 'assets/images/home_img.jpg',
    icon: Icons.diamond_outlined,
  ),
  PopularItem(
    name: 'Professional Wedding Shoot',
    location: 'Delhi, India',
    price: 799.0,
    rating: 4.9,
    imageUrl: 'assets/images/home_img.jpg',
    icon: Icons.camera_alt_rounded,
  ),
];


