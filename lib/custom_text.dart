part of 'customizable_text.dart';

@immutable
class CustomText {
  const CustomText(
    this.text, {
    this.span = 0,
    this.style,
  });

  final String text;
  final int span;
  final TextStyle? style;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomText &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          span == other.span;

  @override
  int get hashCode => text.hashCode + span.hashCode;
}
