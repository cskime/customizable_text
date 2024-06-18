part of 'customizable_text.dart';

@immutable
class CustomText {
  const CustomText(
    this.text, {
    this.span = 0,
    this.style,
    this.onTap,
  });

  final String text;
  final int span;
  final TextStyle? style;
  final void Function(String text)? onTap;

  GestureRecognizer? get tapGestureRecognizer {
    if (onTap == null) {
      return null;
    }

    final recognizer = TapGestureRecognizer();
    recognizer.onTap = () => onTap!(text);
    return recognizer;
  }

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
