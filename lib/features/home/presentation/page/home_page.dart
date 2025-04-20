import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/firebase_category/firebase_category_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/firebase_category/firebase_category_bloc_event.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/firebase_category/firebase_category_bloc_state.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/animated_search_bar.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/carousel_widget.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/section_header.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/horizontal_grid_view.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<FirebaseCategoryBloc, FirebaseCategoryState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FirebaseCategoryBlocInitial) {
                context.read<FirebaseCategoryBloc>().add(VenueCategoryEvent());
                return const Center(child: CircularProgressIndicator());
              } else if (state is FirestoreCategoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FirebaseCategoryLoaded) {
                return ListView.builder(
                  itemCount: state.venues.length,
                  itemBuilder: (context, index) {
                    final venue = state.venues[index];
                    // return VenueCard(venue: venue);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AnimatedSearchBar(),
                        CarouselWidget(carouselItems: carouselItems),
                        const SectionHeader(title: 'Venues'),
                        HorizontalGridView(
                            itemCount: state.venues.length), // Popular items

                        const SizedBox(height: 20), // Space between sections

                        const SectionHeader(title: 'Recently'),
                        const HorizontalGridView(
                            itemCount: 10), // Recently added items
                      ],
                    );
                  },
                );
              } else if (state is FirebaseCategoryError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),

          //   return Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const AnimatedSearchBar(),
          //       CarouselWidget(carouselItems: carouselItems),
          //       const SectionHeader(title: 'Venues'),
          //       const HorizontalGridView(itemCount: 10), // Popular items

          //       const SizedBox(height: 20), // Space between sections

          //       const SectionHeader(title: 'Recently'),
          //       const HorizontalGridView(
          //           itemCount: 10), // Recently added items
          //     ],
          //   );
          // },
        ),
      ),
    );
    // );
  }

  // Carousel Slides
  final carouselItems = [
    Container(
      color: const Color.fromARGB(255, 171, 171, 171),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
        child: Image.asset(
          'assets/images/wedding_venues.jpg',
          fit: BoxFit.fill, // Fill the container while preserving aspect ratio
          width: double.infinity, // Make the image fill the width
        ),
      ),
    ),
    Container(
      color: const Color.fromARGB(255, 171, 171, 171),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
        child: Image.asset(
          'assets/images/wedding_jewllery.jpg',
          fit: BoxFit.fill, // Fill the container while preserving aspect ratio
          width: double.infinity, // Make the image fill the width
        ),
      ),
    ),
    Container(
      color: const Color.fromARGB(255, 171, 171, 171),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
        child: Image.asset(
          'assets/images/wedding_shoot.jpg',
          fit: BoxFit.fill, // Fill the container while preserving aspect ratio
          width: double.infinity, // Make the image fill the width
        ),
      ),
    ),
    Container(
      color: const Color.fromARGB(255, 171, 171, 171),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
        child: Image.asset(
          'assets/images/wedding_dress.jpg',
          fit: BoxFit
              .fitWidth, // Fill the container while preserving aspect ratio
          width: double.infinity, // Make the image fill the width
        ),
      ),
    ),
  ];
}
