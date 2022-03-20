import 'package:flutter/material.dart';
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
    final specialization = item.specialization;

    String getFormattedPostalCode(String postalCode) {
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
                if (specialization != null) Text(specialization),
                Text(item.title),
                const Spacer(),
                Row(
                  children: [Text('${item.street ?? item.city} ${item.houseNumber}')],
                ),
                Text('${item.city}, ${getFormattedPostalCode(item.postalCode)}')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
