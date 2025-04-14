import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vr_wedding_rental/core/utils/carousel_custom/carousel_widget.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/venues_bloc/venues_state.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/carousel_widget.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/horizontal_grid_view.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/section_header.dart';

buildHomePage(BuildContext context, VenueLoaded state) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselWidget(carouselItems: carouselItems),
              const SectionHeader(title: 'Venues'),
              HorizontalGridView(
                itemCount: state.venues.length,
                state: state,
              ), // Venues items

              SizedBox(height: 20.h), // Space between sections

              const SectionHeader(title: 'Recently'),
              HorizontalGridView(
                itemCount: state.venues.length,
                state: state,
              ), // Recently added items
            ],
          ),
        ),
      ),
    );
  }