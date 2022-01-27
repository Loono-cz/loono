import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:provider/provider.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.onItemTap,
  }) : super(key: key);

  final ValueChanged<HealthcareProvider>? onItemTap;

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
        suggestionsCallback: (query) {
          // TODO: multi search query
          if (query.isEmpty) return <HealthcareProvider>[];
          return context.read<MapStateService>().searchByTitle(query);
        },
        itemBuilder: (context, HealthcareProvider healthcareProvider) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text((healthcareProvider.title) + (' (${healthcareProvider.city})')),
            subtitle: Text(healthcareProvider.category.join(', ')),
          );
        },
        onSuggestionSelected: (HealthcareProvider suggestion) => onItemTap?.call(suggestion),
      ),
    );
  }
}
