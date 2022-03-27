import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/find_doctor/search_results_list.dart';
import 'package:loono/ui/widgets/scrollbar.dart';
import 'package:loono/utils/registry.dart';

class SearchHistoryList extends StatelessWidget {
  SearchHistoryList({Key? key}) : super(key: key);

  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _usersDao.watchUser(),
      builder: (context, snapshot) {
        final searchHistory = snapshot.data?.searchHistory;
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
            Expanded(
              child: LoonoScrollbar(
                child: SearchResultsList(
                  searchResults: searchHistory,
                  searchQueryText: null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
