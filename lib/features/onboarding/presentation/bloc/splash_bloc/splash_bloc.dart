import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/features/onboarding/presentation/bloc/splash_bloc/splash_state.dart';

import 'splash_event.dart';


class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial());

  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    if (event is LoadSplash) {
      // Simulate some initialization work
      await Future.delayed(const Duration(seconds: 2));
      yield SplashLoaded();
    }
  }
}
