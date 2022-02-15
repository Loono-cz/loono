import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:provider/provider.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.onItemTap,
  }) : super(key: key);

  final ValueChanged<SearchResult>? onItemTap;

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
          if (query.isEmpty) return <SearchResult>[];
          return context.read<MapStateService>().search(query);
        },
        itemBuilder: (context, SearchResult searchResult) {
          return ListTile(
            leading: Icon(searchResult.icon),
            title: Text(searchResult.text),
            subtitle: searchResult.searchType == SearchType.title
                ? Text(searchResult.data.category.join(', '))
                : null,
          );
        },
        onSuggestionSelected: (SearchResult suggestion) => onItemTap?.call(suggestion),
      ),
    );
  }
}
