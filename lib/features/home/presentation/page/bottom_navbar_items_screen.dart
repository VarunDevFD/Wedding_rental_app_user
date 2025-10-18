import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/core/navigation/bloc/navigation_bloc.dart';
import 'package:vr_wedding_rental/core/navigation/navigation_handler.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/features/home/presentation/page/booking_screen.dart';
import 'package:vr_wedding_rental/features/home/presentation/page/favorites_screen.dart';
import 'package:vr_wedding_rental/features/profile/presentation/pages/profile_screen.dart';
import 'package:vr_wedding_rental/features/home/presentation/page/home_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: NavigationHandler.handleNavigation(
        pageController: pageController,
        pages: _bottomNavScreens,
        items: _bottomNavItems,
      ),
    );
  }

  // Bottom Navigation Items
  final List<BottomNavigationBarItem> _bottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home, color: AppColors.buttonTextColor),
      label: 'Home',
      backgroundColor: AppColors.bottomNavBarBGColor,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.book, color: AppColors.buttonTextColor),
      label: 'Booking',
      backgroundColor: AppColors.bottomNavBarBGColor,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite, color: AppColors.buttonTextColor),
      label: 'Favorites',
      backgroundColor: AppColors.bottomNavBarBGColor,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person, color: AppColors.buttonTextColor),
      label: 'Profile',
      backgroundColor: AppColors.bottomNavBarBGColor,
    ),
  ];

  // The screens for each Bottom Navigation tab
  final List<Widget> _bottomNavScreens = [
    HomeScreen(),
    const BookingScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];
}
