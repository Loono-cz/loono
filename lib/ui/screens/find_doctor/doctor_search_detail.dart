import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/search_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/ui/widgets/find_doctor/search_detail_search_history_list.dart';
import 'package:loono/ui/widgets/find_doctor/search_result_list_item.dart';
import 'package:loono/ui/widgets/find_doctor/search_text_field_icon.dart';
import 'package:provider/provider.dart';

class DoctorSearchDetailScreen extends StatefulWidget {
  const DoctorSearchDetailScreen({Key? key}) : super(key: key);

  @override
  State<DoctorSearchDetailScreen> createState() => _DoctorSearchDetailScreenState();
}

class _DoctorSearchDetailScreenState extends State<DoctorSearchDetailScreen> {
  final _textEditingController = TextEditingController();

  String get _searchQueryText => _textEditingController.text;

  bool get _isSearchQueryEmpty => _searchQueryText.isEmpty;

  @override
  Widget build(BuildContext context) {
    final mapState = context.watch<MapStateService>();
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: TextFormField(
                autofocus: true,
                controller: _textEditingController,
                textAlignVertical: TextAlignVertical.bottom,
                onChanged: (input) {
                  if (input.isEmpty) {
                    mapState.clearSearchResults();
                  } else {
                    mapState.search(input);
                  }
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  iconColor: LoonoColors.primaryEnabled,
                  focusColor: LoonoColors.primaryEnabled,
                  focusedBorder: _customInputDecoration(color: LoonoColors.primaryEnabled),
                  enabledBorder: _customInputDecoration(color: LoonoColors.primaryEnabled),
                  prefixIconConstraints: searchIconConstraints,
                  suffixIconConstraints: searchIconConstraints,
                  prefixIcon: const SearchTextFieldIcon(),
                  suffixIcon: _isSearchQueryEmpty
                      ? const SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            _textEditingController.text = '';
                            mapState.clearSearchResults();
                          },
                          child: const SearchTextFieldIcon(
                            assetPath: 'assets/icons/find_doctor/search_clear.svg',
                          ),
                        ),
                  filled: true,
                  hintStyle: LoonoFonts.paragraphFontStyle.copyWith(color: LoonoColors.grey),
                  hintText: context.l10n.find_doctor_search_hint,
                ),
              ),
            ),
            if (_isSearchQueryEmpty)
              Expanded(child: SearchHistoryList())
            else
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 20, 28, 0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      scrollbarTheme: Theme.of(context).scrollbarTheme.copyWith(
                            thumbColor: MaterialStateProperty.all(LoonoColors.primaryWashed),
                            trackColor: MaterialStateProperty.all(LoonoColors.beigeLighter),
                            trackBorderColor: MaterialStateProperty.all(Colors.transparent),
                            trackVisibility: MaterialStateProperty.all(true),
                          ),
                    ),
                    child: Column(
                      children: [
                        if (_searchQueryText.length > 2 &&
                            mapState.specializationSearchResults.isNotEmpty)
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 40),
                              child: Wrap(
                                spacing: 4,
                                children: mapState.specializationSearchResults
                                    .map(
                                      (specialization) => ActionChip(
                                        label: Text(specialization.text),
                                        onPressed: () {
                                          // TODO: save to history
                                          mapState.setSpecialization(specialization);
                                          AutoRouter.of(context).pop();
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        Expanded(
                          child: Scrollbar(
                            isAlwaysShown: true,
                            child: ListView.builder(
                              itemCount: mapState.searchResults.length,
                              itemBuilder: (context, index) {
                                final searchResult = mapState.searchResults[index];
                                return SearchResultListItem(
                                  searchResult: searchResult,
                                  searchQuery: _searchQueryText,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  UnderlineInputBorder _customInputDecoration({required Color color}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 2.0,
      ),
    );
  }
}
