import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

class DoctorSearchDetailScreen extends StatefulWidget {
  const DoctorSearchDetailScreen({Key? key}) : super(key: key);

  @override
  State<DoctorSearchDetailScreen> createState() => _DoctorSearchDetailScreenState();
}

class _DoctorSearchDetailScreenState extends State<DoctorSearchDetailScreen> {
  final textEditingController = TextEditingController();
  late final MapStateService mapStateService;

  final _usersDao = registry.get<DatabaseService>().users;

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final mapStateService = context.watch<MapStateService>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: LoonoColors.black),
        leading: IconButton(
          icon: SizedBox(
            height: 25,
            width: 25,
            child: SvgPicture.asset('assets/icons/arrow_back.svg'),
          ),
          onPressed: () => AutoRouter.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: textEditingController,
                onChanged: (input) {
                  if (input.isNotEmpty) {
                    mapStateService.search(input);
                  }
                  setState(() {
                    _searchQuery = input;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  iconColor: LoonoColors.primaryEnabled,
                  focusColor: LoonoColors.primaryEnabled,
                  focusedBorder: customInputDecoration(color: LoonoColors.primaryEnabled),
                  enabledBorder: customInputDecoration(color: LoonoColors.primaryEnabled),
                  prefixIcon: const Icon(Icons.search, color: LoonoColors.primaryEnabled),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      textEditingController.text = '';
                      mapStateService.clearSearchResults();
                    },
                    child: const Icon(Icons.close, color: LoonoColors.primaryEnabled),
                  ),
                  filled: true,
                  hintText: 'Zadej odbornost nebo adresu',
                ),
              ),
              if (_searchQuery.isEmpty)
                Expanded(
                  child: StreamBuilder<User?>(
                    stream: _usersDao.watchUser(),
                    builder: (context, snapshot) {
                      final searchHistory = snapshot.data?.searchHistory.take(10);
                      if (searchHistory == null || searchHistory.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('poslední hledání'.toUpperCase()),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchHistory.length,
                            itemBuilder: (context, index) {
                              final searchResult = SearchResult(
                                searchType: SearchType.address,
                                data: searchHistory.elementAt(index),
                              );
                              return _buildSearchResultListTile(
                                searchResult,
                                mapStateService,
                                context,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                )
              else
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: mapStateService.searchResults.length,
                      itemBuilder: (context, index) {
                        final searchResult = mapStateService.searchResults[index];
                        return _buildSearchResultListTile(
                          searchResult,
                          mapStateService,
                          context,
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildSearchResultListTile(
    SearchResult searchResult,
    MapStateService mapStateService,
    BuildContext context,
  ) {
    return ListTile(
      leading: Icon(searchResult.icon),
      minLeadingWidth: 10,
      onTap: () async {
        // TODO: save as SearchResult
        // dismiss keyboard
        FocusManager.instance.primaryFocus?.unfocus();
        switch (searchResult.searchType) {
          case SearchType.address:
            await _usersDao.addSearchHistoryItem(searchResult.data);
            break;
          case SearchType.city:
            break;
        }
        await AutoRouter.of(context).pop(searchResult);
      },
      title: Text(searchResult.text),
      dense: true,
    );
  }

  UnderlineInputBorder customInputDecoration({required Color color}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 2.0,
      ),
    );
  }
}
