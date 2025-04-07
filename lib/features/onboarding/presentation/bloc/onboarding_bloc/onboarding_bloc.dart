import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:vr_wedding_rental/features/onboarding/domain/usecases/get_onboarding_pages_usecase.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final GetOnboardingPagesUseCase getOnboardingPagesUseCase = serviceLocator();
  final CompleteOnboardingUseCase completeOnboardingUseCase = serviceLocator();

  OnboardingCubit() : super(const OnboardingState(currentPage: 0, pages: [])) {
    loadOnboardingPages();
  }

  Future<void> loadOnboardingPages() async {
    emit(state.copyWith(isLoading: true));
    try {
      final pages = await getOnboardingPagesUseCase.call();
      emit(state.copyWith(pages: pages, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void nextPage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  void skipToEnd() async {
    final lastPageIndex = state.pages.length - 1;
    emit(state.copyWith(currentPage: lastPageIndex));
    await completeOnboardingUseCase.execute();
  }
}
