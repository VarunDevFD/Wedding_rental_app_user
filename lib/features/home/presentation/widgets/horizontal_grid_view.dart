import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/features/home/domain/entities/venue.dart';

class HorizontalGridView extends StatelessWidget {
  final int itemCount;
  final Venue? venue;

  const HorizontalGridView({
    super.key,
    required this.itemCount,
    this.venue,
  });

  @override
  Widget build(BuildContext context) {
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
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/placeholder.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Card $index'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
