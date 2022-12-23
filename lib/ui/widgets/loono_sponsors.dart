import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/space.dart';

class LoonoSponsors extends StatelessWidget {
  const LoonoSponsors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LoonoColors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _Sponsor(
                  label: context.l10n.incubated,
                  logoAsset: LoonoAssets.cdLogo,
                  width: 105,
                ),
                const CustomSpacer.horizontal(20),
                _Sponsor(
                  label: context.l10n.with_support,
                  logoAsset: LoonoAssets.ppfLogo,
                  height: 50,
                ),
              ],
            ),
            const CustomSpacer.vertical(35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _Sponsor(
                  label: context.l10n.with_support,
                  logoAsset: LoonoAssets.mzcrLogo,
                  height: 45,
                ),
                _Sponsor(
                  label: context.l10n.technology_partner,
                  logoAsset: LoonoAssets.cgiLogo,
                  height: 50,
                ),
                _Sponsor(
                  label: context.l10n.with_support,
                  logoAsset: LoonoAssets.pragueLogo,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Sponsor extends StatelessWidget {
  const _Sponsor({required this.label, required this.logoAsset, this.width, this.height});

  final String label;
  final String logoAsset;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: LoonoFonts.paragraphSmallFontStyle,
        ),
        const SizedBox(
          height: 9,
        ),
        _buildSponsorImage(),
      ],
    );
  }

  Widget _buildSponsorImage() {
    if (logoAsset.contains('.svg')) {
      if (width != null) {
        return SvgPicture.asset(
          logoAsset,
          width: width,
        );
      } else if (height != null) {
        return SvgPicture.asset(
          logoAsset,
          height: height,
        );
      }
    } else {
      if (width != null) {
        return Image.asset(
          logoAsset,
          width: width,
        );
      } else if (height != null) {
        return Image.asset(
          logoAsset,
          height: height,
        );
      }
    }
    return const SizedBox();
  }
}
