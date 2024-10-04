import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/navigation_bloc.dart';
import 'bloc/navigation_event.dart';
import 'bloc/navigation_state.dart';

class NavigationHandler {
  static Widget handleNavigation({
    required PageController pageController,
    required List<Widget> pages,
    required List<BottomNavigationBarItem> items,
  }) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is NavigationUpdated) {
          // Sync the PageView with the BottomNavigationBar
          pageController.jumpToPage(state.tabIndex);
        }
      },
      builder: (context, state) {
        int currentIndex = 0;
        if (state is NavigationUpdated) {
          currentIndex = state.tabIndex;
        }

        return Scaffold(
          body: PageView(
            controller: pageController,
            onPageChanged: (index) {
              // Change tab when the page is swiped horizontally
              context.read<NavigationBloc>().add(TabChange(tabIndex: index));
            },
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: items,
            currentIndex: currentIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              context.read<NavigationBloc>().add(TabChange(tabIndex: index));
            },
          ),
        );
      },
    );
  }
}
