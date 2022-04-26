import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/text_highlighter.dart';
import 'package:loono/models/search_result.dart';

List<TextSpan> getHighlightedSearchSpans({
  required SearchResult searchResult,
  required String searchQuery,
}) {
  return TextHighlighter.parse(
    searchResult.text,
    highlightPattern: searchQuery,
    shouldNormalize: true,
  )
      .map(
        (item) => TextSpan(
          text: item.text,
          style: item.highlight
              ? LoonoFonts.fontStyle.copyWith(fontWeight: FontWeight.bold)
              : LoonoFonts.fontStyle,
        ),
      )
      .toList();
}

bool isSpecialization(SearchResult searchResult) =>
    searchResult.searchType == SearchType.specialization;

BoxConstraints getSearchIconConstraints({double iconSize = 18.0}) {
  const extraIconPadding = 6.0;
  final defaultIconSize = iconSize + extraIconPadding;
  return BoxConstraints.loose(Size.square(defaultIconSize));
}

InputBorder customSearchInputDecoration({required Color color, InputBorder? inputBorder}) {
  final borderSide = BorderSide(color: color, width: 1.0);
  return inputBorder?.copyWith(borderSide: borderSide) ??
      UnderlineInputBorder(borderSide: borderSide);
}
