import 'package:auto_route/auto_route.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/search_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/ui/widgets/find_doctor/search_detail_search_history_list.dart';
import 'package:loono/ui/widgets/find_doctor/search_results_list.dart';
import 'package:loono/ui/widgets/find_doctor/search_text_field_icon.dart';
import 'package:loono/ui/widgets/scrollbar.dart';
import 'package:provider/provider.dart';

class DoctorSearchDetailScreen extends StatefulWidget {
  const DoctorSearchDetailScreen({Key? key}) : super(key: key);

  @override
  State<DoctorSearchDetailScreen> createState() => _DoctorSearchDetailScreenState();
}

class _DoctorSearchDetailScreenState extends State<DoctorSearchDetailScreen> {
  final _textEditingController = TextEditingController();

  String get _searchQueryText => _textEditingController.text;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      EasyDebounce.debounce(
        '_doctorSearchDetailTextSearchField',
        const Duration(milliseconds: 250),
        () => _onSearchQueryChanged(_searchQueryText),
      );
    });
  }

  void _onSearchQueryChanged(String input) {
    final mapState = context.read<MapStateService>();
    if (input.isEmpty) {
      mapState.clearSearchResults();
    } else {
      mapState.search(input);
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

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
                cursorColor: LoonoColors.black,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  iconColor: LoonoColors.primaryEnabled,
                  focusColor: LoonoColors.primaryEnabled,
                  focusedBorder: customSearchInputDecoration(color: LoonoColors.primaryEnabled),
                  enabledBorder: customSearchInputDecoration(color: LoonoColors.primaryEnabled),
                  prefixIconConstraints: getSearchIconConstraints(),
                  suffixIconConstraints: getSearchIconConstraints(),
                  prefixIcon: const SearchTextFieldIcon(),
                  suffixIcon: _searchQueryText.isEmpty
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
            if (_searchQueryText.isEmpty)
              Expanded(child: SearchHistoryList())
            else
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 20, 28, 0),
                  child: LoonoScrollbar(
                    child: SearchResultsList(
                      searchResults: mapState.searchResults,
                      searchQueryText: _searchQueryText,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
