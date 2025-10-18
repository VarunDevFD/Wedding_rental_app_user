import 'dart:async'; 
import 'package:flutter/material.dart';
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

  SearchBarBloc() : super(SearchBarState('Search for items...')) {
    on<UpdateHintText>((event, emit) => _updateHintText(emit));
    _startHintAnimation();
     
  }

  void _updateHintText(Emitter<SearchBarState> emit) {
    _currentHintIndex = (_currentHintIndex + 1) % hintTextList.length;
    emit(SearchBarState(hintTextList[_currentHintIndex] ));
  }

  void _startHintAnimation() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      add(UpdateHintText());
    });
  }
}
