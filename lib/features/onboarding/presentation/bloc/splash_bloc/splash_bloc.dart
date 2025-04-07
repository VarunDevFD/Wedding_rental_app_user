import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/core/shr_pref/repository/preference_repository.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final preferencesRepository = serviceLocator<PreferencesRepository>();

  SplashBloc() : super(SplashInitial()) {
    on<CheckOnboardingStatus>(_onCheckOnboardingStatus);
  }

  void _onCheckOnboardingStatus(
      CheckOnboardingStatus event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 5));
    bool hasSeenHome = await preferencesRepository.hasSeenHome();
    bool hasSeenOnboarding = await preferencesRepository.hasSeenOnboarding();
    bool hasSeenCategory = await preferencesRepository.hasSeenCategory();
    // String? response = await preferencesRepository.getDataFn();

    if (hasSeenHome == true /*&& response!.isNotEmpty*/) {
      // log(response);
      emit(GoToHome());
    } else if (hasSeenCategory) {
      emit(GoToCategory());
    } else if (hasSeenOnboarding) {
      emit(GoToWelcome());
    } else {
      emit(GoToOnboarding());
    }
  }
}
