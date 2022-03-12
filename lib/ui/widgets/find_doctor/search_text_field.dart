import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono/router/app_router.gr.dart';

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
      child: TextFormField(
        onTap: () async {
          final result = await AutoRouter.of(context).push(const DoctorSearchDetailRoute());
          if (result != null && result is SearchResult) onItemTap?.call(result);
        },
        autofocus: false,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Zadej odbornost nebo adresu',
        ),
      ),
    );
  }
}
