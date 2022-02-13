import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/loono_point.dart';

// TODO:
class SelfExaminationCard extends StatelessWidget {
  SelfExaminationCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final now = DateTime.now();

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      child: SizedBox(
        height: 120.0,
        child: InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _scheduledContent(),
          ),
        ),
      ),
    );
  }

  List<Widget> _scheduledContent() {
    return <Widget>[
      Expanded(
        child: ListTile(
          contentPadding: const EdgeInsets.all(12.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Samovyšetření'),
                  const SizedBox(width: 5),
                  SvgPicture.asset('assets/icons/prevention/appointment_soon.svg'),
                ],
              ),
              Text(
                'ZAČNI SE SAMOVYŠETŘENÍM DNES'.toUpperCase(),
                style: LoonoFonts.cardSubtitle.copyWith(color: LoonoColors.grey),
              ),
              const SizedBox(height: 8.0),
              loonoPointRow(),
            ],
          ),
        ),
      ),
      Align(alignment: Alignment.bottomRight, child: _doctorAsset),
    ];
  }

  Widget get _doctorAsset => ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10),
        ),
        child: SvgPicture.asset(
          'assets/icons/prevention/self_examination/breastSelf.svg',
          width: 100,
        ),
      );

  Widget loonoPointRow() {
    return Row(
      children: const [
        LoonoPointIcon(),
        SizedBox(width: 7.0),
        Text('50', style: LoonoFonts.cardSubtitle),
      ],
    );
  }
}
