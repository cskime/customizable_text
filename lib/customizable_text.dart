import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

part 'custom_text.dart';

typedef _CustomTextPositionInfo = ({CustomText customText, int position});

class CustomizableText extends StatelessWidget {
  const CustomizableText(
    this.text, {
    super.key,
    this.style,
    this.customStyle,
    this.customizes = const [],
  });

  final String text;
  final TextStyle? style;
  final TextStyle? customStyle;
  final List<CustomText> customizes;

  List<_CustomTextPositionInfo> _sortedCustomTextsWithPositionBySpanOrder() {
    var infos = <_CustomTextPositionInfo>[];

    var start = 0;
    for (final customText in customizes) {
      final matches = customText.text.allMatches(text, start).toList();
      final index = min(matches.length - 1, customText.span);
      final position = matches[index].start;
      infos.add((customText: customText, position: position));
      start = position + customText.text.length;
    }

    return infos..sort((a, b) => a.position.compareTo(b.position));
  }

  List<String> _normalTextsUsingCustomTextPositionInfos(
    List<_CustomTextPositionInfo> customTextPositionInfos,
  ) {
    var normalTexts = <String>[];
    var substringIndex = 0;
    for (int index = 0; index < customTextPositionInfos.length; index++) {
      final customTextPositionInfo = customTextPositionInfos[index];
      final normalText = text.substring(
        substringIndex,
        customTextPositionInfo.position,
      );
      normalTexts.add(normalText);
      substringIndex = customTextPositionInfo.position +
          customTextPositionInfo.customText.text.length;
    }

    final lastNormalText = text.substring(substringIndex);
    normalTexts.add(lastNormalText);
    return normalTexts;
  }

  List<TextSpan> _merge(
    List<String> normalTexts,
    List<CustomText> customTexts,
  ) {
    var children = <TextSpan>[];

    for (int index = 0; index < customTexts.length; index++) {
      final normalText = normalTexts[index + 1];
      final customText = customTexts[index];

      children.addAll([
        TextSpan(
          text: customText.text,
          style: customText.style ?? customStyle ?? style,
          recognizer: customText.tapGestureRecognizer,
        ),
        TextSpan(text: normalText),
      ]);
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    final infos = _sortedCustomTextsWithPositionBySpanOrder();
    final normalTexts = _normalTextsUsingCustomTextPositionInfos(infos);
    final children = _merge(
      normalTexts,
      infos.map((info) => info.customText).toList(),
    );
    return Text.rich(
      TextSpan(
        text: normalTexts.first,
        style: style,
        children: children,
      ),
    );
  }
}
