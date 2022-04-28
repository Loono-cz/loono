import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';

class RatingBar extends StatefulWidget {
  const RatingBar({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final ValueChanged<int>? onChanged;

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  int _rating = 0;

  String? get _ratingText {
    switch (_rating) {
      case 1:
        return context.l10n.feedback_rating_1;
      case 2:
        return context.l10n.feedback_rating_2;
      case 3:
        return context.l10n.feedback_rating_3;
      case 4:
        return context.l10n.feedback_rating_4;
      case 5:
        return context.l10n.feedback_rating_5;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            5,
            (i) => Flexible(
              child: GestureDetector(
                onTap: () {
                  final newRating = _rating = i + 1;
                  setState(() => _rating = newRating);
                  widget.onChanged?.call(newRating);
                },
                child: SvgPicture.asset(
                  'assets/icons/feedback/${i <= _rating - 1 ? 'star_filled' : 'star_unfilled'}.svg',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 36),
        Text(
          _ratingText?.toUpperCase() ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: LoonoColors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
