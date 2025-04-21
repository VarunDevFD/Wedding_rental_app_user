import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/firebase_category/firebase_category_bloc_bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/firebase_category/firebase_category_bloc_state.dart';
import 'package:vr_wedding_rental/features/home/presentation/page/venue_details_screen.dart';

class VenueGridView extends StatelessWidget {
  const VenueGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirebaseCategoryBloc, FirebaseCategoryState>(
      
      builder: (context, state) {
        if (state is FirestoreCategoryLoading) {
          return const Center(
            child: LinearProgressIndicator(
              color: Colors.blue,
            ),
          );
        } else if (state is FirebaseCategoryLoaded) {
          return SizedBox(
            height: 200,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // One card per row
                childAspectRatio: 0.6,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: state.venues.length,
              itemBuilder: (context, index) {
                final venue = state.venues[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to VenueDetailsScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VenueDetailsScreen(venue: venue),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Expanded(
                          child: venue.images!.isNotEmpty
                              ? Image.network(
                                  venue.images![0], // Use the first image
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    // log('Error loading image for ${venue.name}: $error');
                                    return Image.asset(
                                      'assets/images/placeholder.jpeg',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/placeholder.jpeg',
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(venue.name!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is FirebaseCategoryError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox(
          height: 200,
          child: Center(
            child: Text('No venues available'),
          ),
        );
      },
    );
  }
}
