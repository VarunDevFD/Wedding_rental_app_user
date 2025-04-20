import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/animation_search_bar_bloc/an_search_bar_state.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/animation_search_bar_bloc/an_search_bloc.dart';

class AnimatedSearchBar extends StatelessWidget {
  const AnimatedSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBarBloc, SearchBarState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(153),
                        blurRadius: 5.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    autofocus:
                        false, // Ensure the keyboard doesn't pop up immediately
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.black,
                      ),
                      hintText: state.hintText,
                      hintStyle: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 12,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      // Close the keyboard after submission
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                height: 38.0,
                width: 38.0,
                decoration: BoxDecoration(
                  color: AppColors.buttonTextColor,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 6.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon:
                      const Icon(Icons.image, color: AppColors.white, size: 20),
                  onPressed: () {
                    // Close the keyboard when this button is clicked
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
