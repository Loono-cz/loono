import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class UpdateProfileItem extends StatelessWidget {
  const UpdateProfileItem({
    Key? key,
    required this.label,
    required this.value,
    required this.route,
  }) : super(key: key);

  final String label;
  final String value;
  final PageRouteInfo route;

  @override
  Widget build(BuildContext context) {
    const textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.transparent),
    );

    return Row(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 100),
          child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.black)),
        ),
        Expanded(
          child: TextField(
            readOnly: true,
            onTap: () => AutoRouter.of(context).push(route),
            decoration: InputDecoration(
              hintText: value,
              hintStyle: const TextStyle(fontSize: 16, color: Colors.black),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: textFieldBorder,
              border: textFieldBorder,
              focusedBorder: textFieldBorder,
            ),
          ),
        ),
      ],
    );
  }
}
