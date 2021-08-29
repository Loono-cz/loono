import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';

class TextHighlighter {
  const TextHighlighter({this.text, this.highlight = false});

  final String? text;
  final bool highlight;

  static List<TextHighlighter> parse(String input, {required String highlightPattern}) {
    final numMatch = RegExp(highlightPattern).firstMatch(input);
    if (numMatch == null) {
      return [TextHighlighter(text: input)];
    }

    final numMatchString = numMatch.group(0)!;
    if (numMatch.start == 0) {
      return [
        TextHighlighter(text: numMatchString, highlight: true),
        TextHighlighter(text: input.substring(numMatchString.length)),
      ];
    } else if (input.endsWith(numMatchString)) {
      return [
        TextHighlighter(text: input.substring(0, numMatch.start)),
        TextHighlighter(text: numMatchString, highlight: true),
      ];
    } else {
      return [
        TextHighlighter(text: input.substring(0, numMatch.start)),
        TextHighlighter(text: numMatchString, highlight: true),
        TextHighlighter(text: input.substring(numMatch.end)),
      ];
    }
  }
}

class CarouselStatContent extends StatelessWidget {
  const CarouselStatContent({
    this.statText = '',
    this.statTextColor = LoonoColors.black,
    this.highlightPattern,
    this.bodyText = '',
    this.button,
    this.dataSourceText = '',
  });

  final String statText;
  final String? highlightPattern;
  final Color statTextColor;
  final String bodyText;
  final String dataSourceText;
  final Widget? button;

  TextStyle get statTextStyle => TextStyle(
        color: statTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 24.0,
      );

  TextStyle get highlightTextStyle => statTextStyle.copyWith(fontSize: 40.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
          child: Column(
            children: [
              const SizedBox(width: double.infinity, height: 50.0),
              RichText(
                textAlign: TextAlign.center,
                text: highlightPattern == null
                    ? TextSpan(text: statText, style: statTextStyle)
                    : TextSpan(
                        children:
                            TextHighlighter.parse(statText, highlightPattern: highlightPattern!)
                                .map(
                                  (item) => TextSpan(
                                    text: item.text,
                                    style: item.highlight ? highlightTextStyle : statTextStyle,
                                  ),
                                )
                                .toList(),
                      ),
              ),
              const SizedBox(height: 60.0),
              Text(
                bodyText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15.0,
                  height: 1.5,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '* ${context.l10n.carousel_content_data_source} $dataSourceText',
                textAlign: TextAlign.center,
                style: LoonoFonts.paragraphSmallFontStyle.copyWith(color: Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ],
          ),
        ),
        if (button != null) button!,
      ],
    );
  }
}

class CarouselImageContent extends StatelessWidget {
  const CarouselImageContent({
    this.headerText = '',
    this.bodyText = '',
    this.bottomText = '',
    this.button,
    this.image,
  });

  final String headerText;
  final String bodyText;
  final String bottomText;
  final Widget? button;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: double.infinity, height: 0.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                headerText,
                textAlign: TextAlign.left,
                style: LoonoFonts.headerFontStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.0296,
                ),
              ),
            ),
            if (image != null) Center(child: image),
            Expanded(child: Container(color: Colors.white)),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.48,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.12),
              child: Center(
                child: Text(
                  bodyText,
                  textAlign: TextAlign.start,
                  style: LoonoFonts.paragraphFontStyle,
                ),
              ),
            ),
          ),
        ),
        if (button != null) button!,
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.06,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text(bottomText, style: LoonoFonts.paragraphFontStyle)),
          ),
        ),
      ],
    );
  }
}
