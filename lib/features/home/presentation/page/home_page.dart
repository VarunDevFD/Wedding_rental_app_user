import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/venues_bloc/venues_bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/venues_bloc/venues_state.dart';
import 'package:vr_wedding_rental/features/home/presentation/widgets/home_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is VenueLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is VenueError) {
          return Center(child: Text(state.message));
        } else if (state is VenueLoaded) {
          return buildHomePage(context, state);
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
