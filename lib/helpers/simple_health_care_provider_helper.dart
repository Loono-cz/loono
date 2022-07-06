import 'package:loono_api/loono_api.dart';

extension SimpleHealthcareProviderHelper on SimpleHealthcareProvider {
  String getStreet() {
    final _street = street;
    if (_street != '' && _street != null) {
      return _street;
    } else {
      return city;
    }
  }

  String getFormattedPostalCode() {
    if (postalCode.length < 5) return postalCode;
    final codeParts = [postalCode.substring(0, 3).trim(), postalCode.substring(3).trim()];
    return '${codeParts[0]} ${codeParts[1]}';
  }

  String get uniqueId => '$locationId-$institutionId';
}
