import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'an_search_bar_state.dart';
import 'an_search_event.dart';
 

class SearchBarBloc extends Bloc<SearchBarEvent, SearchBarState> {
  final List<String> hintTextList = [
    'Search for items...',
    'Search by category...',
    'Find your favorite...',
  ];
  int _currentHintIndex = 0; 
  Timer? _timer;

  SearchBarBloc() : super(SearchBarState('Search for items...', opacity: 1.0)) {
    on<StartHintAnimation>(_onStartHintAnimation);
    on<FadeOutHint>(_onFadeOutHint);
    on<UpdateHintText>(_onUpdateHintText);
    on<FadeInHint>(_onFadeInHint);
  }

 void _onStartHintAnimation(StartHintAnimation event, Emitter<SearchBarState> emit) {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      add(FadeOutHint());
      await Future.delayed(const Duration(milliseconds: 500));
      add(UpdateHintText());
      add(FadeInHint());
    });
  }

  void _onFadeOutHint(FadeOutHint event, Emitter<SearchBarState> emit) {
    emit(state.copyWith(opacity: 0));
  }

  void _onUpdateHintText(UpdateHintText event, Emitter<SearchBarState> emit) {
    _currentHintIndex = (_currentHintIndex + 1) % hintTextList.length;
    emit(state.copyWith(text: hintTextList[_currentHintIndex]));
  }

  void _onFadeInHint(FadeInHint event, Emitter<SearchBarState> emit) {
    emit(state.copyWith(opacity: 1));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
