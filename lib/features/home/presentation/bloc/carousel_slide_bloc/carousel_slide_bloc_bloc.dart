// carousel_bloc.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/carousel_slide_bloc/carousel_slide_bloc_event.dart';
import 'package:vr_wedding_rental/features/home/presentation/bloc/carousel_slide_bloc/carousel_slide_bloc_state.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  int currentIndex = 0;
  final int totalItems;

  CarouselBloc(this.totalItems) : super(CarouselInitial()) {
    on<NextCarouselEvent>((event, emit) {
      currentIndex = (currentIndex + 1) % totalItems; // Cycle through items
      emit(CarouselUpdated(currentIndex)); // Emit the updated state
    });
  }

  void startCarousel() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      add(NextCarouselEvent());
    });
  }
}
