import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:vr_wedding_rental/core/utils/theme/app_colors.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/animation_search_bar_home_bloc/an_search_bar_state.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/animation_search_bar_home_bloc/an_search_bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/category_card_model.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/category_card_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categorylist = [
      'Camera',
      'Dress',
      'Decoration',
      'FootWear',
      'Jewelry',
      'Sound and Dj',
      'Vehicle',
      'Venue',
    ];
    return BlocBuilder<SearchBarBloc, SearchBarState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 6.0),
                      child: Hero(
                        tag: 'searchBarHero',
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black.withAlpha(25),
                                        blurRadius: 5.0,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: TypeAheadField(
                                      suggestionsCallback: (pattern) async {
                                    return categorylist
                                        .where((category) => category
                                            .toLowerCase()
                                            .contains(pattern.toLowerCase()))
                                        .toList();
                                  }, itemBuilder: (context, categorylist) {
                                    return ListTile(
                                      title: Text(categorylist.toString()),
                                    );
                                  }, onSelected: (selected) {
                                    TextEditingController(text: selected);
                                  }, transitionBuilder:
                                          (context, animation, child) {
                                    return FadeTransition(
                                      opacity: CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.fastOutSlowIn),
                                      child: child,
                                    );
                                  }, builder: (context, controller, focusNode) {
                                    return TextField(
                                      controller: controller,
                                      focusNode: focusNode,
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 10,
                                        ),
                                        prefixIcon: IconButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        hintText: state.hintText,
                                        hintStyle: const TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                      onSubmitted: (value) {
                                        // Close the keyboard after submission
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                    );
                                  }),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                  color: AppColors.buttonTextColor,
                                  borderRadius: BorderRadius.circular(25.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(10),
                                      blurRadius: 6.0,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.image,
                                      color: AppColors.white, size: 20),
                                  onPressed: () {
                                    // Close the keyboard when this button is clicked
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    title(),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 columns
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.6, // Adjust for shape
                        ),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return CategoryCard(category: category);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget title() {
    return const Align(
      alignment: Alignment.centerLeft,
      widthFactor: 2.3,
      child: Text(
        "Explore Categories",
        style: TextStyle(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
