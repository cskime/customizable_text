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
    var positionsForCustomText = <CustomText, List<int>>{};

    var start = 0;
    for (final customText in customizes) {
      final position = text.indexOf(customText.text, start);

      positionsForCustomText.update(
        customText,
        (value) => [...value, position],
        ifAbsent: () => [position],
      );

      start = position + customText.text.length;
    }

    return positionsForCustomText.entries
        .expand(
          (entry) => entry.value.map<_CustomTextPositionInfo>(
            (index) => (
              customText: entry.key,
              position: index,
            ),
          ),
        )
        .toList()
      ..sort((a, b) => a.position.compareTo(b.position));
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
