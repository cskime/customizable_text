part of 'customizable_text.dart';

@immutable
class CustomText {
  const CustomText(
    this.text, {
    this.style,
  });
  final String text;
  final TextStyle? style;

  @override
  String toString() {
    return '[[$text]]';
  }
}
