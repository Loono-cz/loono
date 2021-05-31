import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Shortcut to call Provider.of with listen equals to false
T find<T>(BuildContext context) {
  return Provider.of<T>(context, listen: false);
}