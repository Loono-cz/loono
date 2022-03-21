import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono_api/loono_api.dart';

class SearchDoctorCard extends StatelessWidget {
  const SearchDoctorCard({
    Key? key,
    required this.onTap,
    required this.item,
  }) : super(key: key);

  final Function() onTap;
  final SimpleHealthcareProvider item;

  @override
  Widget build(BuildContext context) {
    final _specialization = item.specialization;

    String _getStreet() {
      final _street = item.street;
      if (_street != '' && _street != null) {
        return _street;
      } else {
        return item.city;
      }
    }

    String _getFormattedPostalCode(String postalCode) {
      final codeParts = [postalCode.substring(0, 3).trim(), postalCode.substring(3).trim()];
      return '${codeParts[0]} ${codeParts[1]}';
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 165.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (_specialization != null)
                      Flexible(
                        child: Text(
                          _specialization.toUpperCase(),
                          style: LoonoFonts.cardSubtitle.copyWith(color: LoonoColors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/icons/telephone.svg',
                      color: LoonoColors.grey,
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/icons/at.svg',
                      color: LoonoColors.grey,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    item.title,
                    style: LoonoFonts.cardTitle.copyWith(color: LoonoColors.secondaryFont),
                  ),
                ),
                const Spacer(),
                Text(
                  '${_getStreet()} ${item.houseNumber}',
                  style: LoonoFonts.cardAddress,
                ),
                Text(
                  '${item.city}, ${_getFormattedPostalCode(item.postalCode)}',
                  style: LoonoFonts.cardAddress,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
