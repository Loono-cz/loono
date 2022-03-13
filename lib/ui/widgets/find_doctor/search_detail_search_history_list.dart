import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/find_doctor/search_result_list_item.dart';
import 'package:loono/utils/registry.dart';

class SearchHistoryList extends StatelessWidget {
  SearchHistoryList({Key? key}) : super(key: key);

  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _usersDao.watchUser(),
      builder: (context, snapshot) {
        final searchHistory = snapshot.data?.searchHistory.take(10);
        if (searchHistory == null || searchHistory.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.l10n.find_doctor_search_search_history_title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    color: LoonoColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
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
                return SearchResultListItem(searchResult: searchResult);
              },
            ),
          ],
        );
      },
    );
  }
}
