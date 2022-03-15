import 'package:diacritic/diacritic.dart';

class TextHighlighter {
  const TextHighlighter({
    this.text,
    this.highlight = false,
  });

  final String? text;
  final bool highlight;

  static List<TextHighlighter> parse(
    String input, {
    required String highlightPattern,
    bool shouldNormalize = false,
  }) {
    final numMatch = RegExp(
      shouldNormalize ? removeDiacritics(highlightPattern).toLowerCase() : highlightPattern,
      caseSensitive: !shouldNormalize,
    ).firstMatch(shouldNormalize ? removeDiacritics(input).toLowerCase() : input);
    if (numMatch == null) {
      return [TextHighlighter(text: input)];
    }

    final numMatchString = numMatch.group(0)!;
    if (numMatch.start == 0) {
      return [
        TextHighlighter(text: input.substring(0, numMatch.end), highlight: true),
        TextHighlighter(text: input.substring(numMatchString.length)),
      ];
    } else if (input.endsWith(numMatchString)) {
      return [
        TextHighlighter(text: input.substring(0, numMatch.start)),
        TextHighlighter(text: input.substring(numMatch.start), highlight: true),
      ];
    } else {
      return [
        TextHighlighter(text: input.substring(0, numMatch.start)),
        TextHighlighter(text: input.substring(numMatch.start, numMatch.end), highlight: true),
        TextHighlighter(text: input.substring(numMatch.end)),
      ];
    }
  }
}
