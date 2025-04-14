import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/core/navigation/bloc/navigation_bloc.dart';
import 'package:vr_wedding_rental/core/navigation/navigation_handler.dart';
import 'package:vr_wedding_rental/features/home/presentation/page/booking_screen.dart';
import 'package:vr_wedding_rental/features/home/presentation/page/favorites_screen.dart';
import 'package:vr_wedding_rental/features/home/presentation/page/profile_screen.dart';
import 'package:vr_wedding_rental/features/home/presentation/page/home_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return NavigationHandler.handleNavigation(
      pageController: pageController,
      pages: _bottomNavScreens,
      items: _bottomNavItems,
    );
  }

  // Bottom Navigation Items
  final List<BottomNavigationBarItem> _bottomNavItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  // The screens for each Bottom Navigation tab
  final List<Widget> _bottomNavScreens = [
    const HomePage(),
    const BookingScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];
}
