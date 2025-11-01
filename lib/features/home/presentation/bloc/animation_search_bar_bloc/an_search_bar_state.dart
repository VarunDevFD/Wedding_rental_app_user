class SearchBarState {
  final String hintText;
  final double opacity;
  SearchBarState(this.hintText, {this.opacity = 1.0});
  SearchBarState copyWith({String? text, double? opacity}) {
    return SearchBarState(
      text ?? hintText,
      opacity: opacity ?? this.opacity,
    );
  }
}
