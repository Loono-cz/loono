import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:loono/repositories/healthcare_repository.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/utils/registry.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({
    Key? key,
    required this.onItemTap,
  }) : super(key: key);

  final void Function(HealthcareProvider)? onItemTap;

  final _healthcareProvidersRepository = registry.get<HealthcareProviderRepository>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          style: DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true,
            hintText: 'Zadej adresu, jméno lékaře nebo odbornost',
          ),
        ),
        debounceDuration: const Duration(milliseconds: 300),
        hideOnEmpty: true,
        suggestionsCallback: (pattern) async {
          // TODO: multi search query
          if (pattern.isEmpty) return <HealthcareProvider>[];
          return _healthcareProvidersRepository.searchByTitle(pattern);
        },
        itemBuilder: (context, HealthcareProvider healthcareProvider) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text((healthcareProvider.title) + (' (${healthcareProvider.city})')),
            subtitle: Text(healthcareProvider.category.join(', ')),
            onTap: () => onItemTap?.call(healthcareProvider),
          );
        },
        onSuggestionSelected: (HealthcareProvider healthcareProvider) {
          // TODO: navigate to doctor detail
        },
      ),
    );
  }
}
