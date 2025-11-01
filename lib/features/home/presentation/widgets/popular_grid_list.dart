import 'package:flutter/material.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/popular_grid_card_widget.dart';

class PopularModelGridView extends StatelessWidget {
  const PopularModelGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const PopularCard();
      },
    );
  }
}
